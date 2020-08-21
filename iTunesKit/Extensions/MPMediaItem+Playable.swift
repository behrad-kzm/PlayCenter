//
//  MPMediaItem+Playable.swift
//  iTunesKit
//
//  Created by Behrad Kazemi on 8/17/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
import MediaPlayer

public extension MPMediaItem {
  func asPlayable() -> Playable? {
    guard let url = assetURL else { return nil }
    
    return Playable(uid: String(persistentID), url: url, format: url.pathExtension, source: .iTunes)
  }
}

