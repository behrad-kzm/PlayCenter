//
//  MusicPlayerViewModel.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
struct MusicPlayerViewModel {
  let artistName: String
  let songTitle: String
  let artworkPath: String
  let duration: Double
}
extension MusicPlayerViewModel{
  static let defaultValue = MusicPlayerViewModel(artistName: DefaultText.artistName.rawValue.localize, songTitle: DefaultText.songTitle.rawValue.localize, artworkPath: DefaultText.artworkPlaceholder.rawValue.localize, duration: 0.0)
}
