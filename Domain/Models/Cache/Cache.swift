//
//  Cache.swift
//  Domain
//
//  Created by Behrad Kazemi on 8/21/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation

public final class Cache<Key: Hashable, Value> {
  private let wrapped = NSCache<WrappedKey, Entry>()
  
  func insert(_ value: Value, forKey key: Key) {
    let entry = Entry(value: value)
    wrapped.setObject(entry, forKey: WrappedKey(key))
  }
  
  func value(forKey key: Key) -> Value? {
    let entry = wrapped.object(forKey: WrappedKey(key))
    return entry?.value
  }
  
  func removeValue(forKey key: Key) {
    wrapped.removeObject(forKey: WrappedKey(key))
  }
  
  subscript(key: Key) -> Value? {
    get { return value(forKey: key) }
    set {
      guard let value = newValue else {
        // If nil was assigned using our subscript,
        // then we remove any value for that key:
        removeValue(forKey: key)
        return
      }
      
      insert(value, forKey: key)
    }
  }
}
