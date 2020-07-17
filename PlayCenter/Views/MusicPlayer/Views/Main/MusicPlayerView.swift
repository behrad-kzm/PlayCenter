//
//  MusicPlayerView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/10/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct MusicPlayerView: View {
  
  //MARK: - Properties
  @State private var sliderValue: Double = 0
  @State var viewModel: MusicPlayerViewModel
  @State var upNexts: [SongViewModel]
  @State var showUpNext = false
  var body: some View {
    NavigationView{
      GeometryReader { proxy in
          VStack(alignment: .center,spacing: 8){
            self.makeArtwork(proxy)
            Text(self.viewModel.artistName)
              .font(.callout)
            Text(self.viewModel.songTitle)
              .font(.footnote)
            self.makeSlider(proxy).padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
            Spacer()
            
          }
      }.navigationBarItems(trailing:
          Button(action: {
              self.showUpNext.toggle()
          }) {
              Image(systemName: "bell.circle.fill")
                  .font(Font.system(.title))
          }
      )
    }.sheet(isPresented: self.$showUpNext) {
        UpNextSongsView(upNexts: self.upNexts)
    }
  }

  
  func makeArtwork(_ proxy: GeometryProxy) -> some View {
    let width = proxy.size.width * 0.6
    return Image(viewModel.artworkPath).resizable().aspectRatio(contentMode: .fill).frame(width: width, height: width).clipShape(Circle()).overlay(
      Circle().stroke(Color.white, lineWidth: 3))
      .shadow(radius: 10).padding(EdgeInsets(top: 32, leading: 0, bottom: 32, trailing: 0))
  }
  
  func makeSlider(_ proxy: GeometryProxy) -> some View {
    let width = proxy.size.width * 0.9
    return ZStack {
      Slider(value: $sliderValue, in: -100...100, step: 0.1).padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
      
      }.frame(width: width, height: 16)
  }
  
}

struct MusicPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    MusicPlayerView(viewModel: MusicPlayerViewModel.defaultValue, upNexts: [SongViewModel.defaultValue])
  }
}
