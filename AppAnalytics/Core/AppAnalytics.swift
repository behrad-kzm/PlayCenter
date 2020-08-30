//
//  AppAnalytics.swift
//  AppAnalytics
//
//  Created by Behrad Kazemi on 8/30/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
import Firebase
import UIKit
public struct AppAnalytics: AnalyticsUseCaseProvider {
  
  public static let instance = AppAnalytics()
  
  init() {
    
  }
  
  public func setupAnalytics() {
    FirebaseApp.configure()
    if let userId = UIDevice.current.identifierForVendor?.uuidString{
      Analytics.setUserID(userId)
    }
  }
}

