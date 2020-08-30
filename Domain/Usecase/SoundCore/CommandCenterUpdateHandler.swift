//
//  CommandCenterUpdateHandler.swift
//  Domain
//
//  Created by Behrad Kazemi on 8/30/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
public protocol CommandCenterUpdateHandler {
  func updateInfoCenter(withModel currentItem: Playable?, currentTime: TimeInterval)
}
