//
//  AudioFileHandler.swift
//  Domain
//
//  Created by Behrad Kazemi on 7/11/19.
//  Copyright © 2019 Behrad Kazemi. All rights reserved.
//

import Foundation
import Combine

public protocol AudioFileHandler {
	func handleNewMusic(url: URL) -> AnyPublisher<Void, Never>
	func handleNewItunesMusic(url: URL) -> AnyPublisher<Void, Never>
}
