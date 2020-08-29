//
//  Date+Preview.swift
//  Utils
//
//  Created by Behrad Kazemi on 8/24/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
extension TimeInterval {
   var formattedDuration: String {
    guard self > 0 && self < Double.infinity else {
      return "unknown".localize
    }
    let time = NSInteger(self)
    var result = ""
    let appendStringToResult: (Int, String, String) -> String = { (value, label, previous) -> String in
      return value > 0 ? "\(value) \(label.localize) \(previous)" : previous
    }
    let minutes = (time / 60) % 60
    result = appendStringToResult(minutes,"minutes",result)

    let hours = (time / 3600) % 24
    result = appendStringToResult(hours,"hours",result)
    
    let days = (time / 86400)
    result = appendStringToResult(days,"days",result)

    return result
  }
}
