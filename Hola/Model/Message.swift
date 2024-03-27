//
//  Messages.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import Foundation

// MARK: - Message
struct Message: Codable, Identifiable {
    let id, messageID: String
    let inbox: String?
    let read: Bool?
    let from: Person
    let to,cc, bcc, replyTo: [Person]
    let subject: String
    let created: String
    let returnPath: String?
    let tags: [String]
    let size: Int
    let snippet: String?
    let text, html: String?
    let attachments: [String]?
    let inline: [String]?
    let raw: String?
    let headers: Headers?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case messageID = "MessageID"
        case inbox = "Inbox"
        case read = "Read"
        case from = "From"
        case to = "To"
        case cc = "Cc"
        case bcc = "Bcc"
        case replyTo = "ReplyTo"
        case returnPath = "ReturnPath"
        case subject = "Subject"
        case created = "Created"
        case tags = "Tags"
        case text = "Text"
        case html = "HTML"
        case size = "Size"
        case inline = "Inline"
        case attachments = "Attachments"
        case snippet = "Snippet"
        case raw = "Raw"
        case headers = "Headers"
    }
    
    func formattedSize() -> String {
        let byteSize = Double(size)
        let kilobyteSize = byteSize / 1024.0
        let megabyteSize = kilobyteSize / 1024.0

        if megabyteSize >= 1.0 {
            return String(format: "%.2f MB", megabyteSize)
        } else {
            return String(format: "%.2f KB", kilobyteSize)
        }
    }
}

// MARK: - Person
struct Person: Codable {
    let name: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case address = "Address"
    }
}

// MARK: - Headers
struct Headers: Codable {
    let contentType, date, from, messageID: String
    let mimeVersion, received, returnPath, subject: String
    let to: String

    enum CodingKeys: String, CodingKey {
        case contentType = "Content-Type"
        case date = "Date"
        case from = "From"
        case messageID = "Message-Id"
        case mimeVersion = "Mime-Version"
        case received = "Received"
        case returnPath = "Return-Path"
        case subject = "Subject"
        case to = "To"
    }
}
