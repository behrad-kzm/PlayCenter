//
//  Localizable+Ex.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/15/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
extension String {
  var localize: String {
    return NSLocalizedString(self, comment: "")
  }
}
