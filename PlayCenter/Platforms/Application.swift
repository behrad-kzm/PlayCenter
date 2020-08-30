//
//  Application.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI
import UIKit
import Domain
import SoundCore
import iTunesKit
import AppAnalytics
import RateKit

struct Application {
  
  static var shared = Application()
  public let package: Platforms
  private init() {
    self.package = Platforms(soundCore: SoundCore.UseCaseProvider(), iTunesKit: iTunesKit.iTunesCore(), analyticsCore: AppAnalytics.instance, caches: Domain.MetaDataLoader.instance)
  }
  
  mutating func setup(with window: UIWindow) {
    let tabBarController = UITabBarController()
//    let mainNavigationController = UINavigationController(rootViewController: tabBarController)
    UIApplication.shared.beginReceivingRemoteControlEvents()
    package.analyticsCore.setupAnalytics()
    let rootVC = iTunesSongsRouter(platforms: package).makeModule()
    tabBarController.viewControllers = [rootVC]
    tabBarController.selectedIndex = 1
//
    RateKit.instance.requestReviewIfNeeded()
    window.subviews.first?.removeFromSuperview()
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
    package.soundCore.makeFullPlayerUsecase().setCommandControlUpdateHandler(object: CommandCenterUpdateHandler(caches: package.caches))
  }
}
