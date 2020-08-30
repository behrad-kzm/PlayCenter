//
//  RateKit.swift
//  RateKit
//
//  Created by Behrad Kazemi on 8/30/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import StoreKit

public struct RateKit {
  public static let instance = RateKit()
  
  public var shouldPresentRateView = true
  public func requestReviewIfNeeded() {
    if shouldPresentRateView {
      SKStoreReviewController.requestReview()
    }
  }
}
