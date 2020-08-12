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
  
  @State var upNexts = [SongViewModel]()
  
  var upNextStream: AnyPublisher<[Playable], Never>
  let useCase: FullPlayerUsecase
  
  private var cancellableSet: Set<AnyCancellable> = []
  
  init(useCase: FullPlayerUsecase) {
    self.useCase = useCase
    print("asda sd")
    self.upNextStream = useCase.getUpNext()
    self.upNextStream
    .removeDuplicates()
      .map { (items) -> [SongViewModel] in
      return items.compactMap{$0.asSongViewModel()}
    }.assign(to: \.upNexts, on: self)
    .store(in: &cancellableSet)
  }
  
  func upNext(list: [Playable]) {
    useCase.setUpNext(list: list)
  }
}
