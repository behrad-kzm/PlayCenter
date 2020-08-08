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
struct Application {
  
  static var shared = Application()
  public let package: Platforms
  private init() {
    self.package = Platforms(soundCore: SoundCore.UseCaseProvider())
    let url = Bundle.main.url(forResource: "Test", withExtension: "mp3")!
    let url1 = Bundle.main.url(forResource: "Test1", withExtension: "mp3")!
    let url2 = Bundle.main.url(forResource: "Test2", withExtension: "mp3")!
    
    let file = Playable(uid: UUID().uuidString, url: url, format: "mp3")
    let file1 = Playable(uid: UUID().uuidString, url: url1, format: "mp3")
    let file2 = Playable(uid: UUID().uuidString, url: url2, format: "mp3")
    package.soundCore.makeFullPlayerUsecase().setup(models: [file, file1, file2], index: 0)
  }
  
  mutating func setup(with window: UIWindow) {
    let tabBarController = UITabBarController()
//    let mainNavigationController = UINavigationController(rootViewController: tabBarController)
    let controlCenterUseCase = package.soundCore.makeFullPlayerUsecase()
    let controlCenterViewModel = ControlCenterVM(useCase: controlCenterUseCase)
    let controlCenter = ControlCenterView(viewModel: controlCenterViewModel)
    let rootVC = UIHostingController(rootView: controlCenter)
    
    tabBarController.viewControllers = [rootVC]
    tabBarController.selectedIndex = 1
//

    window.subviews.first?.removeFromSuperview()
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
  }
}
