//
//  CollectionCellViewModel.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 9/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Combine
import Domain
import UIKit

class CollectionCellViewModel: ObservableObject, Identifiable {
  
  //MARK: - Properties
  var id = UUID()
  var items: [Playable]
  var title: String
  var metaData: Domain.MetaDataLoader
  //MARK: - Initialize
  init(items: [Playable], title: String = "CollectionPlaceholder".localize, metaData: Domain.MetaDataLoader) {
    self.items = items
    self.title = title
    self.metaData = metaData
  }
  
  //MARK: - functions

}

extension CollectionCellViewModel {
  static let defaultValue = CollectionCellViewModel(items: (0...(1...3).randomElement()!).compactMap { (_) -> Playable? in
    Playable(uid: UUID().uuidString, url: Bundle.main.url(forResource: "test", withExtension: "mp3")!, format: "mp3")
  }, metaData: MetaDataLoader.instance)
}
