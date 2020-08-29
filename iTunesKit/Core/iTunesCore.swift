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
import Combine
public struct iTunesCore: Domain.iTunesSongsUseCases {

  private let songsSubject: CurrentValueSubject<[Playable], Never>
  public var permissionStatus: MPMediaLibraryAuthorizationStatus {
    return MPMediaLibrary.authorizationStatus()
  }
  
  public init(){
//    library.beginGeneratingLibraryChangeNotifications()
    self.songsSubject = CurrentValueSubject<[Playable], Never>(iTunesCore.loadAllSongs())
  }
  
  public func requestPermissionIfNeeded(_ handler: @escaping (MPMediaLibraryAuthorizationStatus) -> Void) {
    if permissionStatus != .authorized {
      MPMediaLibrary.requestAuthorization { (status) in
        if status == .authorized{
          self.songsSubject.send(iTunesCore.loadAllSongs())
        }
        handler(status)
      }
      return
    }
    handler(permissionStatus)
  }
  
  public func mediaPlayerChange(){}
  
  public func loadAllSongs() -> CurrentValueSubject<[Playable], Never>{
    return songsSubject
  }
  
  static func loadAllSongs() -> [Playable]{
    if MPMediaLibrary.authorizationStatus() == .authorized {
      let songsQuery = MPMediaQuery.songs()
      songsQuery.groupingType = .title
      if let safeItems = songsQuery.items {
        return safeItems.compactMap { (item) -> Playable? in
          
          return item.asPlayable()
        }
      }
    }
    return []
  }
  
}
