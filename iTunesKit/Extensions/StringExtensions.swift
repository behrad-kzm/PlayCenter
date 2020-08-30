//
//  StringExtensions.swift
//  iTunesKit
//
//  Created by Behrad Kazemi on 8/18/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation

extension String {
  func slice(from: String, to: String) -> String? {
    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        String(self[substringFrom..<substringTo])
      }
    }
  }
}
