//
//  ListPlaceholderView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/29/20.
//  Copyright (c) 2020 Behrad Kazemi. All rights reserved.
//
//  This file was generated by the BEK module generator.
//

import SwiftUI

struct ListPlaceholderView: View {
  
  // MARK: -  Properties
  @ObservedObject var viewModel: ListPlaceholderViewModel
  
  init(viewModel: ListPlaceholderViewModel){
    self.viewModel = viewModel
  }
  
  var body: some View {
    GeometryReader { proxy in
      VStack(alignment: .center, spacing: 8) {
        Image("ListIcon")
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .foregroundColor(Color("LightGrayImageColor"))
          .frame(width: proxy.size.width/3, height: proxy.size.width/3, alignment: .center)
          
        VStack(alignment: .leading,spacing: 8){
          Text("There are no songs in your library")
            .font(.headline)
          self.makeOptionsView(proxy)
        }
      }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
    }
  }
  
  func makeOptionsView(_ proxy: GeometryProxy) -> some View {
    let result = VStack(alignment: .leading, spacing: 0) {
      ForEach(viewModel.types, id: \.self) { option in
        HStack(alignment: .center, spacing: 5) {
          Text("-")
          Button(action: {
            self.viewModel.router.performAction(for: option)
          }) {
            Text(option.asOptionDescription()!)
          }
        }
      }
    }
    
    return result
  }
}

struct ListPlaceholderView_Previews: PreviewProvider {
  static var previews: some View {
      ListPlaceholderView(viewModel: ListPlaceholderViewModel(router: ListPlaceholderRouter(platforms: Application.shared.package), types: [.iTunes]))
        .previewLayout(.sizeThatFits)
        .frame(width: 320, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
  }
}
