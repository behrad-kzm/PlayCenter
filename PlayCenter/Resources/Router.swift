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
  
  var baseViewController: UIViewController?
  let platforms: Platforms
  
  init(platforms: Platforms) {
    self.platforms = platforms
  }
  
  func prepareFor(error: Error){
    
  }
}
