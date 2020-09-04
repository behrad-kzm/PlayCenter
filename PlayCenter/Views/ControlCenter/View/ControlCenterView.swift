//
//  ControlCenterView.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI

struct ControlCenterView: View {
  
  //MARK: - Properties
  @ObservedObject var viewModel: ControlCenterVM
  @State var sliderValue: Double = 0.0
  @State var showUpNext = false
  @State var sliderIsSeeking = false
  
  init(viewModel: ControlCenterVM){
    self.viewModel = viewModel
    self.sliderValue = viewModel.currentTime
    self.showUpNext = false
    self.sliderIsSeeking = false
  }
  
  var body: some View {
      GeometryReader { proxy in
        VStack(alignment: .center,spacing: 8){
          NotchView().padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
          Spacer()
          self.makeArtwork(proxy)
          Text(self.viewModel.title)
            .font(.headline)
          Text("\(self.viewModel.artist) - \(self.viewModel.album)")
            .font(.footnote)
          self.makeSlider(proxy).padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
          Spacer()
          self.makePlayerDock()
            .frame(width: proxy.size.width, height: 100, alignment: .center)
          Spacer()
          ZStack(){
            Rectangle().foregroundColor(Color("BackgroundColor"))
            self.makeUpNextButton().padding(.bottom)
          }
          .frame( maxHeight: proxy.size.height * 0.13)
          .gesture(
            DragGesture(minimumDistance: 25)
              .onChanged({ (value) in
                let distance = abs(value.location.y - value.startLocation.y)
                if distance > 100 {
                  self.showUpNext.toggle()
                  self.showUpNextIfNeeded()
                }
              })
          )
            .gesture(
              TapGesture().onEnded({ (_) in
                self.showUpNext.toggle()
                self.showUpNextIfNeeded()
              })
          )
        }.background(Color("BackgroundColor"))
      }.edgesIgnoringSafeArea(.bottom)
  }
  
  func showUpNextIfNeeded() {
    if showUpNext {
      showUpNext = false
      self.viewModel.router.showUpNext()
    }
  }
}

struct ControlCenterView_Previews: PreviewProvider {
  static var previews: some View {
    ControlCenterView(viewModel: ControlCenterVM(router: ControlCenterRouter(platforms: Application.shared.package)))
  }
}
