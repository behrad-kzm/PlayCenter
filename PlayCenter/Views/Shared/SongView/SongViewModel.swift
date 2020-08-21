//
//  SongViewModel.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/15/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Domain
struct SongViewModel: Identifiable {
  
  let id = UUID()
  let title: String
  let artwork: Data?
  var model: Playable?
}

extension SongViewModel{
  static let defaultValue = SongViewModel(title: DefaultText.songTitle.rawValue.localize, artwork: nil, model: nil)
}

extension Playable {
  func asSongViewModel(loader: MetaDataLoader) -> SongViewModel{
    SongViewModel(title: loader.loadTitle(for: self) ?? DefaultText.songTitle.rawValue.localize, artwork: loader.loadArtwork(for: self), model: self)
  }
}
