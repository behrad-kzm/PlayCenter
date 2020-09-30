//
//  SearchBar.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 9/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
  @State var value: String = ""

  var body: some View {
    GeometryReader{ proxy in
      ZStack(alignment: .leading) {
        VisualEffectView(effect: UIBlurEffect(style: .regular))
          .cornerRadius(16)

        HStack(alignment: .center, spacing: 0) {
          
          Image("SearchButton")
            .renderingMode(.template)
          .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.gray.opacity(0.8))
            .padding(.all, 16)
          TextField("SearchPlaceholder".localize, text: self.$value)
            
          Image("CloseButton")
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color.gray.opacity(0.8))
            .padding(.all, 10)
            .onTapGesture(count: 1, perform: {
              self.value = ""
            })
          
        }.padding(.horizontal, 4)
      }
    }
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    ZStack(alignment: .center, content: {
      Image("Test.background")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .edgesIgnoringSafeArea(.all)
        
      SearchBar()
        .frame(width: 320, height: 48, alignment: .center)
    }).previewLayout(.sizeThatFits)
      .frame(width: 320, height: 48, alignment: .center)
  }
}
