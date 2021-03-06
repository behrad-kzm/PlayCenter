//
//  iTunesSongsRouter.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/17/20.
//  Copyright (c) 2020 Behrad Kazemi. All rights reserved.
//
//  This file was generated by the BEK module generator.
//

import UIKit
import Domain
import SwiftUI

final class iTunesSongsRouter: Router {
  
  var hostingViewController: UIHostingController<iTunesSongsView>?
  
  // MARK: - Initialization
  
  func makeModule() -> UIHostingController<iTunesSongsView> {
    return iTunesSongsRouter.createModule(router: self)
  }
  
  static func createModule(router: iTunesSongsRouter) -> UIHostingController<iTunesSongsView> {
    let viewModel = iTunesSongsViewModel(router: router)
    let view = iTunesSongsView(viewModel: viewModel)
    router.hostingViewController = UIHostingController(rootView: view)
    router.baseViewController = router.hostingViewController
    return router.hostingViewController!
  }
  
  //  MARK: - Functions
  func showControlCenter() {
    if let safeBaseController = self.baseViewController {
      let controlCenter = ControlCenterRouter(platforms: platforms).makeModule()
      safeBaseController.present(controlCenter, animated: true, completion: nil)
    }
  }
  
}

