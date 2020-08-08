//
//  ControlCenterVM.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Combine
import Domain
class ControlCenterVM: ObservableObject {
  
  // Input
  @Published var artwork: Data?
  @Published var title = DefaultText.songTitle.rawValue.localize
  @Published var artist = DefaultText.artistName.rawValue.localize
  @Published var album = DefaultText.albumName.rawValue.localize
  @Published var duration = 100.0
  @Published var currentTime = 0.0
  @Published var state = PlayerStatus.stopped
  @Published var isShuffle = false
  @Published var isRepeat = false
  @Published var upNexts = [SongViewModel]()
  
  var metaDataStream: AnyPublisher<PlayerInfo, Never>
  private let useCase: FullPlayerUsecase
  
  private var cancellableSet: Set<AnyCancellable> = []
  
  
  init(useCase: FullPlayerUsecase) {
    self.useCase = useCase
    self.metaDataStream = useCase.getPlayerInformation()
    
    ///making state
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> PlayerStatus in
        return info.status
      }.assign(to: \.state, on: self)
      .store(in: &cancellableSet)
    
    ///making title
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> String in
        return info.currentModel?.loadTitle() ?? DefaultText.songTitle.rawValue.localize
      }.assign(to: \.title, on: self)
      .store(in: &cancellableSet)
    
    ///making album
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> String in
        return info.currentModel?.loadAlbum() ?? DefaultText.albumName.rawValue.localize
      }.assign(to: \.album, on: self)
      .store(in: &cancellableSet)

    ///making artwork
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> Data? in
        return info.currentModel?.loadArtwork()
      }.assign(to: \.artwork, on: self)
      .store(in: &cancellableSet)
    
    ///making artist
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> String in
        return info.currentModel?.loadArtist() ?? DefaultText.artistName.rawValue.localize
      }.assign(to: \.artist, on: self)
      .store(in: &cancellableSet)
    
    ///making duration
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> Double in
        return info.duration
      }.assign(to: \.duration, on: self)
      .store(in: &cancellableSet)
    
    ///making currentTime
    self.metaDataStream
      .receive(on: RunLoop.main).map { (info) -> Double in
        return info.currentTime
      }.assign(to: \.currentTime, on: self)
      .store(in: &cancellableSet)
    
  }
  
  //MARK: - functions
  func play(){
    useCase.resume()
  }
  
  func pause() {
    useCase.pause()
  }
  
  func next() {
    useCase.next()
  }
  
  func previous() {
    useCase.previous()
  }
  
  func resume() {
    useCase.resume()
  }
  
  func seekTo(desiredTime time: TimeInterval){
    useCase.seekTo(destination: time)
  }
}
