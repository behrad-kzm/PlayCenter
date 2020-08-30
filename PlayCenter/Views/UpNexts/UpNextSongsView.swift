//
//  UpNextSongsView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/15/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI
import Combine

struct UpNextSongsView: View {
  
  @ObservedObject var viewModel: UpNextVM
  var body: some View {
    
    GeometryReader{ proxy in
        VStack(alignment: .center, spacing: 0) {
          NotchView().padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
          VStack(alignment: .leading, spacing: 16, content: {
            HStack(alignment: .center, spacing: 0) {
              Text("UpNext".localize).font(.title).fontWeight(.semibold).padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
              Spacer()
              EditButton().padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
            self.makeList(proxy)
          })
      }
    }
  }
  
  func makeList(_ proxy: GeometryProxy) -> some View {
    let cellSize = CGSize(width: proxy.size.width, height: 48)
    return List {
      ForEach(viewModel.upNexts) { songVM in
        SongView(viewModel: songVM)
          .frame(width: cellSize.width, height: cellSize.height, alignment: .leading)
      }.onMove(perform: move)
    }.onAppear { UITableView.appearance().tableFooterView = UIView() }
    .onDisappear { UITableView.appearance().tableFooterView = nil }
  }
  
  func move(from source: IndexSet, to destination: Int) {
    var tempItems = viewModel.upNexts
    tempItems.move(fromOffsets: source, toOffset: destination)
    viewModel.upNext(list: tempItems.compactMap{ $0.model})
  }
}

struct UpNextSongsView_Previews: PreviewProvider {
  static var previews: some View {
    UpNextSongsView(viewModel: UpNextVM(router: UpNextSongsRouter(platforms: Application.shared.package)))
    //      .previewLayout(.sizeThatFits)
    //      .previewDisplayName("Default preview")
  }
}
