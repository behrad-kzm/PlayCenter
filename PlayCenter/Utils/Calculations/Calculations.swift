//
//  Calculations.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 9/25/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

public struct Calculations {
  static func progress(byValue value: CGFloat, fromMainValue main: CGFloat,maximum: CGFloat = 1.0,minimum: CGFloat = 0.0, revert: Bool = false) -> CGFloat{
    var progress = value / main
    if revert { progress = 1 - progress }
    let difference = abs(maximum - minimum)
    let extra = progress * difference
    let returnValue = min(maximum, minimum) + extra
    return returnValue
  }
  static func rangeForGrid(otherSideCount: Int, count: Int) -> Range<Int>{
    guard otherSideCount > 0 && count > 0 else {
      return 0..<0
    }
    let max = CGFloat(count) / CGFloat(otherSideCount)
    let rounded = Int(ceil(max))
    return (0..<rounded+1)
  }
  
}

extension Array {
  func limited(size: Int) -> [Element]{
    return (0..<size).compactMap { (index) -> Element? in
      if index < self.count {
        return self[index]
      }
      return nil
    }
  }
}
