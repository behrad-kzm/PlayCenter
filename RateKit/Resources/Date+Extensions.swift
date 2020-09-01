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

extension Formatter {
  static let custom: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyyMMddHHmmss"
    return formatter
  }()
}
