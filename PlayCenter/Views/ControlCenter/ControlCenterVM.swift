//
//  ControlCenterVM.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/6/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Combine
import Domain
class ControlCenterVM: ObservableObject {
  
  // Input
  @Published var artwork: Data?
  @Published var title = DefaultText.songTitle.rawValue.localize
  @Published var artist = DefaultText.artistName.rawValue.localize
  @Published var album = DefaultText.albumName.rawValue.localize
  @Published var duration = 100.0
  @Published var currentTime = 0.0
  @Published var state = PlayerStatus.stopped
  @Published var isShuffle = false
  @Published var isRepeat = false
  
  var metaDataStream: AnyPublisher<PlayerInfo, Never>
  let useCase: Domain.FullPlayerUsecase
  let caches: Domain.MetaDataLoader
  
  let router: ControlCenterRouter
  
  private var cancellableSet: Set<AnyCancellable> = []
  
  
  init(router: ControlCenterRouter) {
    self.useCase = router.platforms.soundCore.makeFullPlayerUsecase()
    self.caches = router.platforms.caches
    self.metaDataStream = useCase.getPlayerInformation()
    self.router = router
    self.setup()
  }
  
  //MARK: - Setup
   func setup(){
     metaDataStream
       .receive(on: RunLoop.main).map { (info) -> PlayerStatus in
         return info.status
       }.assign(to: \.state, on: self)
       .store(in: &cancellableSet)
     
     ///making title
     metaDataStream
      .receive(on: RunLoop.main).compactMap({ (value) in
        value.currentModel
      }).map { [caches](value) -> String in
         return caches.loadTitle(for: value) ?? DefaultText.songTitle.rawValue.localize
       }.assign(to: \.title, on: self)
       .store(in: &cancellableSet)
     
     ///making album
     metaDataStream
       .receive(on: RunLoop.main).compactMap({ (value) in
         value.currentModel
       }).map { [caches](value) -> String in
          return caches.loadAlbum(for: value) ?? DefaultText.albumName.rawValue.localize
       }.assign(to: \.album, on: self)
       .store(in: &cancellableSet)

     ///making artwork
     metaDataStream
       .receive(on: RunLoop.main).compactMap({ (value) in
         value.currentModel
       }).map { [caches](value) -> Data? in
        return caches.loadArtwork(for: value)
       }.assign(to: \.artwork, on: self)
       .store(in: &cancellableSet)
     
     ///making artist
     metaDataStream
       .receive(on: RunLoop.main).compactMap({ (value) in
         value.currentModel
       }).map { [caches](value) -> String in
          return caches.loadArtist(for: value) ?? DefaultText.artistName.rawValue.localize

       }.assign(to: \.artist, on: self)
       .store(in: &cancellableSet)
     
     ///making duration
     metaDataStream
       .receive(on: RunLoop.main).map { (info) -> Double in
         return info.duration
       }.assign(to: \.duration, on: self)
       .store(in: &cancellableSet)
     
     ///making currentTime
     metaDataStream
       .receive(on: RunLoop.main).map { (info) -> Double in
         return info.currentTime
       }.assign(to: \.currentTime, on: self)
       .store(in: &cancellableSet)
   }
  
  //MARK: - functions
  func play(){
    useCase.resume()
  }
  
  func pause() {
    useCase.pause()
  }
  
  func next() {
    useCase.next()
  }
  
  func previous() {
    useCase.previous()
  }
  
  func resume() {
    useCase.resume()
  }
  
  func seekTo(desiredTime time: TimeInterval){
    useCase.seekTo(destination: time)
  }
  
}
