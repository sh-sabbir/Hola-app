//
//  Item.swift
//  Hola
//
//  Created by Sabbir Hasan on 27/2/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
