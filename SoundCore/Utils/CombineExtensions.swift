//
//  CombineExtensions.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 7/22/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
import Combine

public extension Publisher {
  func mapToVoid() -> AnyPublisher<Void,  Self.Failure> {
    return self.map { (_) -> Void in }.eraseToAnyPublisher()
  }
}
