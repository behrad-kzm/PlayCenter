//
//  Platforms.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain

struct Platforms {
  let soundCore: Domain.SoundUsecaseProvider
  let iTunesKit: Domain.iTunesSongsUseCases
  let analyticsCore: Domain.AnalyticsUseCaseProvider
  let caches: Domain.MetaDataLoader
}
