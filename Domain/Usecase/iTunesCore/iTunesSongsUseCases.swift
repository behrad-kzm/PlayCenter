//
//  iTunesSongsUseCases.swift
//  Domain
//
//  Created by Behrad Kazemi on 8/22/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import MediaPlayer
import Combine

public protocol iTunesSongsUseCases {
  var permissionStatus: MPMediaLibraryAuthorizationStatus { get }
  func requestPermissionIfNeeded(_ handler: @escaping (MPMediaLibraryAuthorizationStatus) -> Void)
  func loadAllSongs() -> CurrentValueSubject<[Playable], Never>
}
