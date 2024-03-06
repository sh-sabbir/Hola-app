//
//  MessageDetailView.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import SwiftUI

struct MessageDetailView: View {
    let message: Message
    
    var body: some View {
        VStack {
            Text("From: \(message.from.name)")
            Text("Subject: \(message.subject)")
            Text("Snippet: \(message.snippet)")
        }
        .padding()
    }
}
