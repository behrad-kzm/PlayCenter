//
//  SoundPlayer.swift
//  SoundsPlatform
//
//  Created by Behrad Kazemi on 6/14/19.
//  Copyright © 2019 Behrad Kazemi. All rights reserved.
//
import UIKit
import AVFoundation
import MediaPlayer
import Domain
import Combine

public class SoundPlayer: NSObject, AVAudioPlayerDelegate {
  // MARK: - Properties
  private var audioPlayer = AVAudioPlayer()
  private let audioSession = AVAudioSession()
  private let remoteHandlers = RemoteControllersHandler()
  
  var repeatType = MPRepeatType.off
  var shuffled: Bool! {
    didSet {
      if shuffled {
        playingAudios.shuffle()
        return
      }
      playingAudios = audios
    }
  }
  private(set) var current: Playable? {
    didSet {
      currentObs.send(current)
    }
  }
  
  private(set) var status: PlayerStatus! {
    didSet {
      statusObs.send(status)
    }
  }
  var currentTime: TimeInterval {
    return current != nil ? audioPlayer.currentTime : 0
  }
  private(set) var currentObs: CurrentValueSubject<Playable?, Never>!
  private(set) var statusObs: CurrentValueSubject<PlayerStatus, Never>!
  private(set) var playingAudios: [Playable]!//because if you had shuffle mode you can able to do the action of 'previous' or you can see the exact upnext songs then you turning off the suffle the exact previous order of audios will restore
  private(set) var audios: [Playable]! {
    didSet {
      playingAudios = audios
    }
  }
  
  public static let shared: SoundPlayer = {
    let manager = SoundPlayer()
    manager.statusObs = CurrentValueSubject<PlayerStatus, Never>(.stopped)
    manager.currentObs = CurrentValueSubject<Playable?, Never>(nil)
    
    manager.status = .stopped
    manager.current = nil
    manager.shuffled = false
    manager.audios = [Playable]()
    do {
      try manager.audioSession.setCategory(.playback)
      try manager.audioSession.setActive(true)
    }catch let error as NSError{
      //			Analytics.logError(fileName: "SoundPlayer", error: error , descriptions: "Failed to set the audio session category and mode: \(error.localizedDescription)")
    }
    manager.remoteHandlers.setupRemoteHandlers(ForManager: manager)
    return manager
  }()
  
  // MARK: - Functions
  func seekTo(desiredTime time: TimeInterval){
    print("settings time tp \(time) from \(audioPlayer.duration)")
    if audioPlayer.duration >= time && time >= 0{
      print("This")
      audioPlayer.currentTime = time
      print("That")
    }
    
  }
  
  public func setup(list: [Playable], index: Int){
    audios = list
    let safeIndex = (index >= list.count) ? (list.count - 1) : index
    current = list[safeIndex]
    play(Model: current!)
  }
  private func play(Model audio: Playable){
    do {
      
      audioPlayer = try AVAudioPlayer(contentsOf: audio.url)
      audioPlayer.delegate = self
      status = .playing
      current = audio
      audioPlayer.play()
      //				self.updateControlCenter()
    } catch {
      next()
      print("Player Error!")
    }
  }
  
  func pause(){
    audioPlayer.pause()
    status = .paused
  }
  
  func resume(){
    audioPlayer.play()
    status = .playing
  }
  
  func stop(){
    
  }
  
  func next(){
    let nextSong: Playable?
    if let safeCurrent = current,
      let safeIndex = playingAudios.firstIndex(of: safeCurrent),
      let next = (safeIndex + 1) < playingAudios.count ? playingAudios[(safeIndex + 1)] : nil{
      nextSong = next
    } else {
      nextSong = playingAudios.first
    }
    
    if let safeCurrent = nextSong {
      play(Model: safeCurrent)
      
    }
  }
  
  func previous(){
    let previousSong: Playable?
    if currentTime > 5, let safeCurrent = current{
      play(Model: safeCurrent)
      return
    }
    
    if let safeCurrent = current,
      let safeIndex = playingAudios.firstIndex(of: safeCurrent),
      let previous = (safeIndex - 1) < playingAudios.count && (safeIndex - 1) >= 0 ? playingAudios[(safeIndex - 1)] : nil{
      previousSong = previous
    } else {
      previousSong = playingAudios.last
    }
    
    if let safeCurrent = previousSong {
      play(Model: safeCurrent)
    }
  }
  //MARK- AVPlayerDelegate
  public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if flag{
      if let safeCurrent = current,
        let safeIndex = playingAudios.firstIndex(of: safeCurrent),
        let _ = (safeIndex + 1) < playingAudios.count ? playingAudios[(safeIndex + 1)] : nil{
        next()
      } else {
        next()
        pause()
      }
    }
  }
}

