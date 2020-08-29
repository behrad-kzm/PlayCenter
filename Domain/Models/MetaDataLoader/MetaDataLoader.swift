//
//  MetaDataLoader.swift
//  Domain
//
//  Created by Behrad Kazemi on 8/21/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import AVKit
import Foundation

public final class MetaDataLoader {
  
  public static let instance = MetaDataLoader()
  
  let artworkCache = Cache<String, Data>()
  let titleCache = Cache<String, String>()
  let artistCache = Cache<String, String>()
  let albumCache = Cache<String, String>()
  let songDurationCache = Cache<String, Double>()
  
  public func loadArtwork(for playable: Playable) -> Data? {
    if let data = artworkCache[playable.uid]{
      return data
    }
    
    let data: Data? = load(url: playable.url, forKey: "artwork")
    artworkCache[playable.uid] = data
    return data
  }
  
  public func loadTitle(for playable: Playable) -> String? {
    if let data = titleCache[playable.uid]{
      return data
    }
    
    let data: String? = load(url: playable.url, forKey: "title")
    titleCache[playable.uid] = data
    return data
  }
  
  public func loadArtist(for playable: Playable) -> String? {
    if let data = artistCache[playable.uid]{
      return data
    }
    
    let data: String? = load(url: playable.url, forKey: "artist")
    artistCache[playable.uid] = data
    return data
  }
  
  public func loadAlbum(for playable: Playable) -> String? {
    if let data = albumCache[playable.uid]{
      return data
    }
    
    let data: String? = load(url: playable.url, forKey: "albumName")
    albumCache[playable.uid] = data
    return data
  }
  
  public func loadSongsDuration(for playable: Playable) -> TimeInterval? {
    if let data = songDurationCache[playable.uid]{
      return data
    }
    
    let data: TimeInterval? = CMTimeGetSeconds(AVAsset(url: playable.url).duration)
    songDurationCache[playable.uid] = data
    return data
  }
  
  public func load<T>(url: URL, forKey key: String) -> T? {
    let asset = AVAsset(url: url)
    return asset.metadata.filter { (item) -> Bool in
      item.commonKey?.rawValue == key
    }.compactMap { (item) -> T? in
      return item.value as? T
    }.first
  }
  
}
