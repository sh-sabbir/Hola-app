//
//  MessageResponse.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import Foundation

struct MessageResponse: Codable {
    let total: Int
    let unread: Int
    let count: Int
    let messagesCount: Int
    let start: Int
    let messages: [Message]
}
