//
//  ListPlaceholderRouter.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/29/20.
//  Copyright (c) 2020 Behrad Kazemi. All rights reserved.
//
//  This file was generated by the BEK module generator.
//

import UIKit
import Domain
import SwiftUI

final class ListPlaceholderRouter: Router {
  
  var hostingViewController: UIHostingController<ListPlaceholderView>?
  
  // MARK: - Initialization
  
  func makeModule(options: [ListPlaceholderType]) -> UIHostingController<ListPlaceholderView> {
    return ListPlaceholderRouter.createModule(router: self, options: options)
  }
  
  static func createModule(router: ListPlaceholderRouter, options: [ListPlaceholderType]) -> UIHostingController<ListPlaceholderView> {
    let viewModel = ListPlaceholderViewModel(router: router, types: options)
    let view = ListPlaceholderView(viewModel: viewModel)
    router.hostingViewController = UIHostingController(rootView: view)
    router.baseViewController = router.hostingViewController
    return router.hostingViewController!
  }
  
  //  MARK: - Functions
  func performAction(for type: ListPlaceholderType) {
    platforms.iTunesKit.requestPermissionIfNeeded { [baseViewController](status) in
      if status != .authorized {
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "iTunesPermissionTitle".localize, message: "iTunesPermissionDescription".localize, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel".localize, style: .default, handler: nil))
          alert.addAction(UIAlertAction(title: "OpenSettings".localize, style: .default, handler: { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
              return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
              UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
              })
            }
          }))
          
          baseViewController?.present(alert, animated: true, completion: nil)
        }
      }
    }
  }
  
}
