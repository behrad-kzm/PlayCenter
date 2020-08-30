//
//  CommandCenterUpdateHandler.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/30/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
import MediaPlayer

public struct CommandCenterUpdateHandler: Domain.CommandCenterUpdateHandler {
  public let caches: MetaDataLoader
  init(caches: MetaDataLoader){
    self.caches = caches
  }
  public func updateInfoCenter(withModel currentItem: Playable?, currentTime: TimeInterval) {
    guard let item = currentItem else { return }
    var nowPlayingInfo : [String : AnyObject] = [
      MPMediaItemPropertyPlaybackDuration : caches.loadSongsDuration(for: item) as AnyObject,
      MPMediaItemPropertyTitle : caches.loadTitle(for: item) as AnyObject,
      MPNowPlayingInfoPropertyElapsedPlaybackTime : currentTime as AnyObject,
      MPMediaItemPropertyMediaType : MPMediaType.music.rawValue as AnyObject,
      MPMediaItemPropertyArtist: caches.loadArtist(for: item) as AnyObject]
    if let data = caches.loadArtwork(for: item), let albumArt = UIImage(data: data) {
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumArt.size, requestHandler: { imageSize in
            return albumArt
        })
    }
    
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
  
}
