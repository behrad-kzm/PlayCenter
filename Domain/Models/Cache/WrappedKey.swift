//
//  WrappedKey.swift
//  Domain
//
//  Created by Behrad Kazemi on 8/21/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}
