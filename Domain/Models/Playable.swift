//
//  Playable.swift
//  Domain
//
//  Created by Behrad Kazemi on 6/14/19.
//  Copyright © 2019 Behrad Kazemi. All rights reserved.
//

import AVKit
public struct Playable: Codable {
  public let uid: String
  public let format: String
  public let url: URL
  public var source: DataSourceType = .local
  public init(uid: String, url: URL, format: String){
    self.uid = uid
    self.format = format
    self.url = url
  }
}

extension Playable: Equatable{
  public static func == (lhs: Playable, rhs: Playable) -> Bool {
    return lhs.uid == rhs.uid && lhs.url == rhs.url
  }
}

extension Playable{
  public func loadArtwork() -> Data? {
    return load(key: "artwork")
  }
  
  public func loadTitle() -> String? {
    return load(key: "title")
  }
  
  public func loadArtist() -> String? {
    return load(key: "artist")
  }
  
  public func loadAlbum() -> String? {
    return load(key: "albumName")
  }
  
  public func load<T>(key: String) -> T? {
    let asset = AVAsset(url: url)
    return asset.metadata.filter { (item) -> Bool in
      item.commonKey?.rawValue == key
    }.compactMap { (item) -> T? in
      return item.value as? T
    }.first
  }
}
