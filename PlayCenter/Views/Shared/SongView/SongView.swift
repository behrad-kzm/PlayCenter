//
//  SongView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/15/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct SongView: View {
  @State var viewModel: SongViewModel
  @State var hideArtistName: Bool = true
  
  var body: some View {
    GeometryReader { proxy in
      self.makeView(proxy)
    }
  }
  
  func makeView(_ proxy: GeometryProxy) -> some View{
    
    var image = UIImage(named: DefaultText.artworkPlaceholder.rawValue.localize)!
    if let safeData = viewModel.artwork, let safeImage = UIImage(data: safeData){
      image = safeImage
    }
    
    return HStack(alignment: .center, spacing: 8) {
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipShape(Circle()).overlay(Circle().foregroundColor(.clear))
//        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .frame(width: proxy.size.height, height: proxy.size.height)
      .shadow(radius: 4)
      VStack(alignment: .leading, spacing: 5) {
        Text(viewModel.title)
          .font(.callout)
        if !self.hideArtistName {
            Text(viewModel.title)
            .font(.footnote)
            .foregroundColor(Color.gray)
        }
      }
    }.frame(width: proxy.size.width, height: proxy.size.height, alignment: .leading)
  }
}

struct SongView_Previews: PreviewProvider {
  static var previews: some View {
    SongView(viewModel: SongViewModel.defaultValue)
      .previewLayout(PreviewLayout.sizeThatFits)
      .previewDisplayName("Default preview")
      .frame(width: 320, height: 64, alignment: .center)
  }
}
