//
//  SoundPlayerToMediaPlaybackProxy.swift
//  SoundCore
//
//  Created by Behrad Kazemi on 8/17/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import MediaPlayer
import Domain

public final class SoundPlayerToMediaPlaybackProxy: MPMediaPlayback {
  
  //MARK: - Properties
  
  let manager: SoundPlayer
  
  var seekTimer: Timer?
  
  public var isPreparedToPlay: Bool = true
  
  public var currentPlaybackTime: TimeInterval {
    
    set {
      manager.seekTo(desiredTime: newValue)
    }
    
    get {
      return manager.currentTime
    }
  }
  
  public var currentPlaybackRate: Float = 320.0
  
  //MARK: - Initialize
  public init(manager: SoundPlayer){
    self.manager = manager
  }
  
  //MARK: - Functions
  public func prepareToPlay() {
    print("prepareToPlay")
  }
    
  public func play() {
    manager.resume()
  }
  
  public func pause() {
    manager.pause()
  }
  
  public func stop() {
    manager.stop()
  }
  
  public func beginSeekingForward() {
    seekTimer = Timer(timeInterval: 0.5, repeats: true, block: { [manager](timer) in
      if timer.isValid {
        manager.seekTo(desiredTime: manager.currentTime + 5)
      }
    })
    seekTimer?.fire()
  }
  
  public func beginSeekingBackward() {
    seekTimer = Timer(timeInterval: 0.5, repeats: true, block: { [manager](timer) in
      if timer.isValid {
        manager.seekTo(desiredTime: manager.currentTime - 5)
      }
    })
    seekTimer?.fire()
  }
  
  public func endSeeking() {
    seekTimer?.invalidate()
    seekTimer = nil
  }
}

