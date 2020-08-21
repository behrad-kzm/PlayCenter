//
//  Entry.swift
//  Domain
//
//  Created by Behrad Kazemi on 8/21/20.
//  Copyright © 2020 Behrad Kazemi. All rights reserved.
//

import Foundation
extension Cache {
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}
