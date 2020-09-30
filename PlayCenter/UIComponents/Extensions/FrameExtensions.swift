//
//  FrameExtensions.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 9/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
  func squareFrame(width: CGFloat ) -> some View {
    self.frame(width: width, height: width)
  }
}
