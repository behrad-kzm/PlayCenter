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
  
  private(set) var minimumScoreForRatingPrompt: Int
  public var currentScoreForRatingPrompt: Int
  public var minimumDaysForPrompt: Int
  public var shouldPresentRateView: Bool {
    return currentScoreForRatingPrompt > minimumScoreForRatingPrompt
  }
  
  init() {
    self.currentScoreForRatingPrompt = UserDefaults.standard.integer(forKey: StorageKeys.userCurrentScoreKey.rawValue)
    self.minimumScoreForRatingPrompt = UserDefaults.standard.integer(forKey: StorageKeys.userMinimumScoreKey.rawValue)
    self.minimumDaysForPrompt = UserDefaults.standard.integer(forKey: StorageKeys.minimumDaysForPromptKey.rawValue)
    
    if let firstInstallDateString = UserDefaults.standard.string(forKey: StorageKeys.firstInstallDateKey.rawValue),
      let firstInstallDate = DateFormatter().date(from: firstInstallDateString){
      self.currentScoreForRatingPrompt += Int(firstInstallDate.days / Double(minimumDaysForPrompt) * 100)
      return
    }

    UserDefaults.standard.set(100, forKey: StorageKeys.userMinimumScoreKey.rawValue)
    UserDefaults.standard.set(0, forKey: StorageKeys.userCurrentScoreKey.rawValue)
    UserDefaults.standard.set(DateFormatter().string(from: Date()), forKey: StorageKeys.firstInstallDateKey.rawValue)
  }
  
  public mutating func increaseRatingScore(_ value: Int){
    let newValue = UserDefaults.standard.integer(forKey: StorageKeys.userCurrentScoreKey.rawValue) + value
    UserDefaults.standard.set(newValue, forKey: StorageKeys.userCurrentScoreKey.rawValue)
    self.currentScoreForRatingPrompt += value
  }
  
  public mutating func decreaseRatingScore(_ value: Int){
    let newValue = UserDefaults.standard.integer(forKey: StorageKeys.userCurrentScoreKey.rawValue) - value
    UserDefaults.standard.set(newValue, forKey: StorageKeys.userCurrentScoreKey.rawValue)
    self.currentScoreForRatingPrompt -= value
  }
  
  public mutating func setMinimumScoreForPrompt(_ value: Int) {
    UserDefaults.standard.set(value, forKey: StorageKeys.userMinimumScoreKey.rawValue)
    self.minimumScoreForRatingPrompt = value
  }
  
  public mutating func setMinimumDaysForPrompt(_ value: Int) {
    UserDefaults.standard.set(value, forKey: StorageKeys.minimumDaysForPromptKey.rawValue)
    self.minimumDaysForPrompt = value
  }
  
  public func requestReviewIfNeeded() {
    if shouldPresentRateView {
      SKStoreReviewController.requestReview()
    }
  }
}
