//
//  Application.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI
import UIKit

struct Application {
  
  static let shared = Application()
  public let package: Platforms
  
  private init() {
    self.package = Platforms()
  }
  
  func setup(with window: UIWindow) {
    
    let tabBarController = UITabBarController()
    let mainNavigationController = UINavigationController(rootViewController: tabBarController)

    let rootVC = UIHostingController(rootView: MusicPlayerView(viewModel: MusicPlayerViewModel.defaultValue, upNexts: [SongViewModel.defaultValue]))
    tabBarController.viewControllers = [rootVC]
    tabBarController.selectedIndex = 1
    
    window.subviews.first?.removeFromSuperview()
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
  }
}
