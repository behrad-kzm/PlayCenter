//
//  CircularArtworkView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/14/20.
//  Copyright (c) 2020 Behrad Kazemi. All rights reserved.
//
//  This file was generated by the BEK module generator.
//

import SwiftUI

struct CircularArtworkView: View {
  
  // MARK: -  Properties
  @ObservedObject var viewModel: CircularArtworkViewModel
  
  init(viewModel: CircularArtworkViewModel){
    self.viewModel = viewModel
  }
  
  var body: some View {
    GeometryReader{ proxy in
      self.makeArtwork(proxy)
    }

  }
  
  func makeArtwork(_ proxy: GeometryProxy) -> some View {
    let height = proxy.size.height
    let image: Image
    if let safeArtworkData = self.viewModel.data, let safeImage = UIImage(data: safeArtworkData) {
      image = Image(uiImage: safeImage)
    } else {
      image = Image(uiImage: UIImage(named: DefaultText.artworkPlaceholder.rawValue.localize)!)
    }
    let artwork = image.resizable().aspectRatio(contentMode: .fill).frame(width: height, height: height).clipShape(Circle()).overlay(
    Circle().stroke(Color.white, lineWidth: self.viewModel.lineWidth))
    if viewModel.hasShadow {
      return artwork.shadow(radius: viewModel.shadow)
    }
    return artwork.shadow(color: .clear, radius: 0, x: 0, y: 0)
  }
}

struct CircularArtworkView_Previews: PreviewProvider {
  static var previews: some View {
    CircularArtworkView(viewModel: CircularArtworkViewModel(model: nil))
    .previewLayout(.sizeThatFits)
    .previewDisplayName("Default preview")
      .background(Color.clear)
      .frame(width: 128, height: 128, alignment: .center)
  }
}
