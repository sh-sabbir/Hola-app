//
//  Messages.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let messageId: String
    let read: Bool
    let from: Sender
    let subject: String
    let created: String
    let snippet: String
    
    struct Sender: Codable {
        let name: String
        let address: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "Name"
            case address = "Address"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "ID"
        case messageId = "MessageID"
        case read = "Read"
        case from = "From"
        case subject = "Subject"
        case created = "Created"
        case snippet = "Snippet"
    }
}
