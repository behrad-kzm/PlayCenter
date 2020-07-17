//
//  SongViewModel.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/15/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
struct SongViewModel: Identifiable {
  let id = UUID()
  let title: String
  let artworkPath: String
//  let model: SongModel
}

extension SongViewModel{
  static let defaultValue = SongViewModel(title: DefaultText.songTitle.rawValue.localize, artworkPath: DefaultText.artworkPlaceholder.rawValue.localize)
}
