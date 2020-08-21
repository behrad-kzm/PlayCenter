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
struct Application {
  
  static var shared = Application()
  public let package: Platforms
  private init() {
    self.package = Platforms(soundCore: SoundCore.UseCaseProvider(), iTunesKit: iTunesKit.iTunesCore(), caches: Domain.MetaDataLoader.instance)
    let core = iTunesCore()
    core.requestPermissionIfNeeded { [package](status) in
      print(status)
      if status == .authorized{
        let allSongs = core.loadAllSongs()
        package.soundCore.makeFullPlayerUsecase().setup(models: allSongs, index: 0)
      }
    }
  }
  
  mutating func setup(with window: UIWindow) {
    let tabBarController = UITabBarController()
//    let mainNavigationController = UINavigationController(rootViewController: tabBarController)
    let rootVC = iTunesSongsRouter(platforms: package).makeModule()
    tabBarController.viewControllers = [rootVC]
    tabBarController.selectedIndex = 1
//

    window.subviews.first?.removeFromSuperview()
    window.rootViewController = rootVC
    window.makeKeyAndVisible()

  }
}
