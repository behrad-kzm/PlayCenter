//
//  UpNextSongsView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/15/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct UpNextSongsView: View {
  @State var upNexts = [SongViewModel]()
  
  var body: some View {
    GeometryReader{ proxy in
      VStack(alignment: .center, spacing: 0) {
        Rectangle()
          .foregroundColor(Color.gray)
        .edgesIgnoringSafeArea(.all)
          .frame(width: 80, height: 4, alignment: .center)
          .cornerRadius(2)
          .padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
        
        VStack(alignment: .leading, spacing: 16, content: {
              
          Text("UpNext".localize).font(.title).fontWeight(.semibold).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
          self.makeList(proxy)
        })

      }
    }
  }
  
  func makeList(_ proxy: GeometryProxy) -> some View {
    let cellSize = CGSize(width: proxy.size.width, height: 48)
    return List(self.upNexts){ songVM in
          SongView(viewModel: songVM)
            .frame(width: cellSize.width, height: cellSize.height, alignment: .leading)
    
    }.onAppear { UITableView.appearance().tableFooterView = UIView() }
    .onDisappear { UITableView.appearance().tableFooterView = nil }
    
  }
}

struct UpNextSongsView_Previews: PreviewProvider {
  static var previews: some View {
    UpNextSongsView(upNexts: [SongViewModel.defaultValue,SongViewModel.defaultValue,SongViewModel.defaultValue,SongViewModel.defaultValue])
//      .previewLayout(.sizeThatFits)
//      .previewDisplayName("Default preview")
  }
}
