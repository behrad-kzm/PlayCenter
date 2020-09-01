//
//  Date+Extensions.swift
//  RateKit
//
//  Created by Behrad Kazemi on 9/1/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
extension Date {
  var days: Double {
    return -1 * self.timeIntervalSinceNow / 86400
  }
}
