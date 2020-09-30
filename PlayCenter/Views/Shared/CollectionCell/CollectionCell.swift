//
//  CollectionCell.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 9/27/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct CollectionCell: View {
  @ObservedObject var viewModel: CollectionCellViewModel
  
  init(viewModel: CollectionCellViewModel){
    self.viewModel = viewModel
  }
  
  var body: some View {
    GeometryReader{ proxy in
      VStack(alignment: .center, spacing: 8, content: {
        ZStack(alignment: .center, content: {
          VisualEffectView(effect: UIBlurEffect(style: .regular))
            .cornerRadius(proxy.size.height / 3.5)
          
            VStack(alignment: .center, spacing: 16, content: {
              ForEach(Calculations.rangeForGrid(otherSideCount: 2, count: viewModel.items.limited(size: 4).count), id: \.self) { (row) in
                HStack(alignment: .center, spacing: 16, content: {
                  ForEach(Calculations.rangeForGrid(otherSideCount: 2, count: viewModel.items.limited(size: 4).count), id: \.self) { (column) in
                    CircularArtworkView(viewModel: CircularArtworkViewModel(model: viewModel.items[row * 2 + column].asSongViewModel(loader: viewModel.metaData).artwork)).squareFrame(width: (proxy.size.width - 48)/2)
                  }
                })
              }
            })
            .padding(.all, 16)
        })
        
      })
    }
  }
}

struct CollectionCell_Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader{ proxy in
      ZStack(alignment: .center, content: {
        Image("Test.background")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .edgesIgnoringSafeArea(.all)
        ScrollView(.vertical, showsIndicators: true, content: {
            ForEach(0...10, id: \.self) { (_) in
              HStack(alignment: .center, spacing: 24, content: {
                CollectionCell(viewModel: CollectionCellViewModel.defaultValue)
                  .frame(width: makeCellSize(proxy.size.width), height: makeCellSize(proxy.size.width), alignment: .center)
                CollectionCell(viewModel: CollectionCellViewModel.defaultValue)
                  .frame(width: makeCellSize(proxy.size.width), height: makeCellSize(proxy.size.width), alignment: .center)
              }).padding(.horizontal, 32)
            }.frame(width: proxy.size.width, alignment: .center)
        })
      }).frame(width: proxy.size.width, alignment: .center)
    }
  }
  
  static func makeCellSize(_ width: CGFloat) -> CGFloat {
    return (width - 88) / 2
  }
}
