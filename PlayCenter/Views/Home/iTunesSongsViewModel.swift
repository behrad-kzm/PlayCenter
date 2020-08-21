//
//  iTunesSongsViewModel.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/17/20.
//  Copyright (c) 2020 Behrad Kazemi. All rights reserved.
//
//  This file was generated by the BEK module generator.
//

import Combine
import Domain

class iTunesSongsViewModel: ObservableObject {
  
  //MARK: - Properties
  @Published var items = [SongViewModel]()
  @Published var toolbarVM: ToolbarViewModel
  var title = "RecentyAdded".localize
  var router: iTunesSongsRouter
  let useCases: Domain.iTunesSongsUseCases
  let caches: Domain.MetaDataLoader
  
  private var cancellableSet: Set<AnyCancellable> = []
  
  //MARK: - Initialize
  init(router: iTunesSongsRouter) {
    self.router = router
    let itunesKit = router.platforms.iTunesKit
    self.useCases = itunesKit
    self.caches = router.platforms.caches
    self.toolbarVM = ToolbarViewModel(router: ToolbarRouter(platforms: router.platforms))
    self.items = itunesKit.loadAllSongs().compactMap({ [caches](items) -> SongViewModel? in
      return items.asSongViewModel(loader: caches)
    })
  }
  
  //MARK: - functions

}