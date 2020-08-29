//
//  NotchView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/24/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct NotchView: View {
  public let notchWidth: CGFloat
  init(width: CGFloat = 80.0) {
    self.notchWidth = width
  }
  var body: some View {
    Rectangle()
      .foregroundColor(Color("GrayBorderColor"))
      .edgesIgnoringSafeArea(.all)
      .frame(width: self.notchWidth, height: 4, alignment: .center)
      .cornerRadius(2)
      
  }
}

struct NotchView_Previews: PreviewProvider {
  static var previews: some View {
    NotchView()
      .previewLayout(.sizeThatFits)
  }
}
