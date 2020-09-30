//
//  ControlCenterDock.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/7/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import SwiftUI
import Domain
import Combine

struct ControlCenterDock: View {
  var isPlayingPublisher: AnyPublisher<Bool, Never>
  @State private(set) var isPlaying: Bool = false
  @State private(set) var shuffleButtonColor: Color = Color("‌ButtonColor")
  var viewModel: ControlCenterVM
  private var cancellableSet: Set<AnyCancellable> = []
  
  public init(isPlayingPublisher: AnyPublisher<Bool, Never>, isPlaying: Bool = false, viewModel: ControlCenterVM){
    
    self.isPlayingPublisher = isPlayingPublisher
    self.viewModel = viewModel
    self.isPlaying = isPlaying
    self.shuffleButtonColor = viewModel.isShuffle ? Color("‌PrimaryColor") : Color("‌ButtonColor")

  }
  mutating func setup(){
    viewModel.metaDataStream.receive(on: RunLoop.main).map { (info) -> Color in
      return info.repeatMode == .off ? Color("‌ButtonColor") : Color("‌PrimaryColor")
    }.assign(to: \.shuffleButtonColor, on: self)
    .store(in: &cancellableSet)
  }
  var body: some View {
    GeometryReader { proxy in
      
      ZStack(){
        self.makePlayButton(proxy, radius: proxy.size.height * 0.33)
        self.makeDockShape(proxy, radius: proxy.size.height * 0.33)
          .shadow(color: Color("MainShadow"), radius: 16, x: 0, y: 20)
        HStack(){
          Rectangle().foregroundColor(.clear).overlay(
            Image("ShuffleButton").renderingMode(.template).resizable().aspectRatio(contentMode: .fit)
              .frame(width: proxy.size.height * 0.2, height: proxy.size.height * 0.2, alignment: .center).accentColor(self.viewModel.isShuffle ? Color("‌PrimaryColor") : Color("‌ButtonColor"))
          ).gesture(
            TapGesture().onEnded({ (_) in
              self.viewModel.shuffleToggle()
              })
          ).padding(EdgeInsets(top: proxy.size.height * 0.33, leading: 0, bottom: 0, trailing: 0))
          self.makeDockButtons(proxy)
          Rectangle().foregroundColor(.clear).overlay(
            (Image("RepeatButton")).renderingMode(.template).resizable().aspectRatio(contentMode: .fit).accentColor(self.viewModel.isRepeat ? Color("‌PrimaryColor") : Color("‌ButtonColor"))
              .frame(width: proxy.size.height * 0.2, height: proxy.size.height * 0.2, alignment: .center)
          ).gesture(
            TapGesture().onEnded({ (_) in
              self.viewModel.repeatToggle()
            })
          ).padding(EdgeInsets(top: proxy.size.height * 0.33, leading: 0, bottom: 0, trailing: 0))
        }
        
        
      }
    }
  }
}

//MARK: - Shapes
extension ControlCenterDock {
  func makeDockButtons(_ proxy: GeometryProxy) -> some View {
    let ratio: CGFloat = 0.26
    return HStack(alignment: .center, spacing: 16){
      
      Rectangle().foregroundColor(.clear).overlay(
        Image("PlayPreviousButton").renderingMode(.template).resizable().aspectRatio(contentMode: .fit)
        .accentColor(Color("‌ButtonColor"))
          .frame(width: proxy.size.height * ratio, height: proxy.size.height * ratio, alignment: .center)
      ).gesture(
        TapGesture().onEnded({ (_) in
          self.viewModel.previous()
        })
      )
      Spacer()
      Rectangle().foregroundColor(.clear).overlay(
        Image("PlayNextButton").renderingMode(.template).resizable().aspectRatio(contentMode: .fit)
          .accentColor(Color("‌ButtonColor"))
          .frame(width: proxy.size.height * ratio, height: proxy.size.height * ratio, alignment: .center)
      ).gesture(
        TapGesture().onEnded({ (_) in
          self.viewModel.next()
        })
      )
      
    }.frame(width: proxy.size.width * 0.5, height: proxy.size.height * 0.667, alignment: .center)
      .padding(EdgeInsets(top: proxy.size.height * 0.33, leading: 0, bottom: 0, trailing: 0))
  }
  
  func makeDockShape(_ proxy: GeometryProxy, radius: CGFloat) -> some View{
    let height = proxy.size.height * 0.667
    let width = proxy.size.width * 0.5
    return DockButtonsShape(cornerRadius: 16, circleRadius: radius + 4).overlay(
      DockButtonsShape(cornerRadius: 16, circleRadius: radius + 4)
        .stroke(Color("GrayBorderColor"), lineWidth: 0.5)
    )
      .foregroundColor(Color("ButtonBackground"))
      .frame(width: width, height: height, alignment: .center)
      .padding(EdgeInsets(top: proxy.size.height * 0.33, leading: 0, bottom: 0, trailing: 0))
  }
  
  func makePlayButton(_ proxy: GeometryProxy, radius: CGFloat = 10) -> some View {
    
    let buttonPadding = proxy.size.height - 2 * radius
    let iconWidth = proxy.size.height * 0.2
    return Circle().foregroundColor(Color("PrimaryColor")).shadow(color: Color("PrimaryColor").opacity(0.3), radius: 3, x: 0, y: 5)
      .overlay(
        (isPlaying == false ? Image("PlayButton") : Image("PauseButton"))
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .frame(width: iconWidth, height: iconWidth, alignment: .center))
      .onReceive(isPlayingPublisher, perform: { (info) in
        self.isPlaying = info
          })
      .padding(EdgeInsets(top: 0, leading: 0, bottom: buttonPadding, trailing: 0))
      .gesture(
        TapGesture().onEnded({ (_) in
          self.isPlaying.toggle()
          self.isPlaying ? self.viewModel.play() : self.viewModel.pause()
          
        })
    )
  }
}


struct ControlCenterDock_Previews: PreviewProvider {
  static var previews: some View {
    ControlCenterDock(isPlayingPublisher: CurrentValueSubject<Bool, Never>(false).eraseToAnyPublisher(),  viewModel: ControlCenterVM(router: ControlCenterRouter(platforms: Application.shared.package)))
      .previewLayout(.sizeThatFits)
      .frame(width: 480, height: 100, alignment: .center)
      .padding(0)
  }
}


