//
//  Router.swift
//  Application
//
//  Created by Behrad Kazemi.
//  Copyright © 2020 BEKFiles. All rights reserved.
//

import Foundation
import UIKit
import Domain

public class Router {
  
  let navigationController: UINavigationController?
  var baseViewController: UIViewController?
  let platforms: Platforms
  
  init(platforms: Platforms, navigationController: UINavigationController?) {
    self.platforms = platforms
    self.navigationController = navigationController
  }
  
  func prepareFor(error: Error){
    
  }
}
