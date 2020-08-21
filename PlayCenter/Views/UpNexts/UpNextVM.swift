//
//  UpNextVM.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/8/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI
import Combine
import Domain

public class UpNextVM: ObservableObject {
  
  @Published var upNexts = [SongViewModel]()
  
  var upNextStream: AnyPublisher<[Playable], Never>
  let useCase: Domain.FullPlayerUsecase
  let caches: Domain.MetaDataLoader
  var router: UpNextSongsRouter
  
  private var cancellableSet: Set<AnyCancellable> = []
  
  init(router: UpNextSongsRouter) {
    self.router = router
    self.useCase = router.platforms.soundCore.makeFullPlayerUsecase()
    self.caches = router.platforms.caches
    self.upNextStream = useCase.getUpNext()
    self.upNextStream
    .removeDuplicates()
      .map { [caches](items) -> [SongViewModel] in
        return items.compactMap{$0.asSongViewModel(loader: caches)}
    }.assign(to: \.upNexts, on: self)
    .store(in: &cancellableSet)
  }
  
  func upNext(list: [Playable]) {
    useCase.setUpNext(list: list)
  }
}
