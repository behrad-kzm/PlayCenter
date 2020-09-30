//
//  ControlCenterComponents.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/7/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

//MARK: - Make Views
extension ControlCenterView {
  func makePlayerDock() -> some View {
   return ControlCenterDock(isPlayingPublisher: viewModel.$state.map({ (state) -> Bool in
      return state == .playing
    }).eraseToAnyPublisher(), isPlaying: self.viewModel.state == .playing, viewModel: self.viewModel)
  }
  func makeUpNextButton() -> some View {
    return ZStack(){
      Text("ShowUpNext".localize)
        .font(.caption)
        .fontWeight(.bold)
        .foregroundColor(Color("‌ButtonColor"))
    }
  }
  
  func makeArtwork(_ proxy: GeometryProxy) -> some View {
    let width = proxy.size.width * 0.6    
    let viewModel = CircularArtworkViewModel(model: self.viewModel.artwork)
    return CircularArtworkView(viewModel: viewModel)
      .frame(width: width, height: width)
      .padding(EdgeInsets(top: 32, leading: 0, bottom: 32, trailing: 0))
  }
  
  func makeSlider(_ proxy: GeometryProxy) -> some View {
    let width = proxy.size.width * 0.9
    return ZStack {
      Slider(value: Binding(
        get: {
          return self.sliderValue
      },
        set: {(newValue) in
          self.sliderValue = newValue
      }), in: 0...self.viewModel.duration, step: 0.1) { (isSeeking) in
        if !isSeeking {
          self.viewModel.seekTo(desiredTime: self.sliderValue)
        }
        self.sliderIsSeeking = isSeeking
      }.onReceive(self.viewModel.$currentTime, perform: { (value) in
        if !self.sliderIsSeeking {
          self.sliderValue = value
        }
      }).padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        .accentColor(Color("PrimaryColor"))
      
    }.frame(width: width, height: 16)
  }
}
