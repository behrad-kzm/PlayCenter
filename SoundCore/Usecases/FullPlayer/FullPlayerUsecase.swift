//
//  FullPlayerUsecase.swift
//  SoundsPlatform
//
//  Created by Behrad Kazemi on 6/20/19.
//  Copyright © 2019 Behrad Kazemi. All rights reserved.
//

import Domain
import MediaPlayer
import Combine

public final class FullPlayerUsecase: Domain.FullPlayerUsecase {
  
  let manager: SoundPlayer
  
  init(manager: SoundPlayer) {
    self.manager = manager
  }
  
  public func setup(models: [Playable], index: Int) {
    manager.setup(list: models, index: index)
  }
  
  public func next() {
    manager.next()
  }
  
  public func previous() {
    manager.previous()
  }
  
  public func getUpNext() -> AnyPublisher<[Playable], Never> {
    
    return manager.currentObs
      .map({ (model) -> [Playable] in
        if let safeModel = model, let currentIndex = self.manager.playingAudios.firstIndex(of: safeModel) {
          let splitedArray = Array(self.manager.playingAudios[currentIndex ..< self.manager.playingAudios.count].dropFirst())
          return splitedArray
        }
        return [Playable]()
      }).eraseToAnyPublisher()
  }
  
  public func pause() {
    manager.pause()
  }
  
  public func resume() {
    manager.resume()
  }
  
  public func seekForward(duration: TimeInterval) {
    let desired = manager.currentTime + duration
    manager.seekTo(desiredTime: desired)
  }
  
  public func seekBakward(duration: TimeInterval) {
    let desired = manager.currentTime - duration
    manager.seekTo(desiredTime: desired)
  }
  
  public func seekTo(destination: TimeInterval) {
    manager.seekTo(desiredTime: destination)
  }
  
  public func getPlayerInformation() -> AnyPublisher<PlayerInfo, Never> {
    
    let currentChanged = manager.currentObs.removeDuplicates { (prev, next) -> Bool in
      return prev?.uid == next?.uid
    }.mapToVoid()
    
    let statusChanged = manager.statusObs.removeDuplicates { (prev, next) -> Bool in
      return prev.rawValue == next.rawValue
    }.mapToVoid()
    
    let repeatitiveEvent = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect().mapToVoid()
    
    let checkingEvent = Publishers.Merge3(repeatitiveEvent, currentChanged, statusChanged).eraseToAnyPublisher()
    return checkingEvent.map { [unowned self](_) -> PlayerInfo in
      var duration = 0.0
      if let safeCurrent = self.manager.current, let current = try? AVAudioPlayer(contentsOf: safeCurrent.url) {
        duration = current.duration
      }
      return PlayerInfo(currentModel: self.manager.current, currentTime: self.manager.currentTime, isShuffle: self.manager.shuffled, repeatMode: self.manager.repeatType, status: self.manager.status, duration: duration)
    }.eraseToAnyPublisher()
  }
  public func setSuffle(isSheffled: Bool) {
    manager.shuffled = isSheffled
  }
  public func setRepeat(mode: MPRepeatType) {
    manager.repeatType = mode
  }
  public func setUpNext(list: [Playable]) {
    manager.setUpNext(list: list)
  }
}
