//
//  iTunesCore.swift
//  iTunesKit
//
//  Created by Behrad Kazemi on 8/17/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import MediaPlayer
import Domain

public struct iTunesCore: Domain.iTunesSongsUseCases {
  private let library: MPMediaLibrary
  public var permissionStatus: MPMediaLibraryAuthorizationStatus {
    return MPMediaLibrary.authorizationStatus()
  }
  
  public init(){
    self.library = MPMediaLibrary.default()
    library.beginGeneratingLibraryChangeNotifications()
    
  }
  
  public func requestPermissionIfNeeded(_ handler: @escaping (MPMediaLibraryAuthorizationStatus) -> Void) {
    if permissionStatus != .authorized {
      MPMediaLibrary.requestAuthorization { (status) in
       handler(status)
      }
      return
    }
    handler(permissionStatus)
  }
  
  public func mediaPlayerChange(){}
  
  public func loadAllSongs() -> [Playable]{
    let songsQuery = MPMediaQuery.songs()
    songsQuery.groupingType = .title
    if let safeItems = songsQuery.items {
      return safeItems.compactMap { (item) -> Playable? in
        
        return item.asPlayable()
      }
    }
    return []
  }
  
}
