//
//  ListPlaceholderType.swift
//  PlayCenter
//
//  Created by Behrad Kazemi on 8/29/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
public enum ListPlaceholderType {
  case iTunes
  case fromSafari
  case fromPC
  case otherApps
}

public extension ListPlaceholderType {
  func asOptionDescription() -> String?{
    let dictionary: [ListPlaceholderType: String] = [.iTunes: "Connect iTunes library", .fromSafari: "Import from safari", .otherApps: "Import from other apps", .fromPC: "Import from PC"]
    
    return dictionary[self]
  }
}
