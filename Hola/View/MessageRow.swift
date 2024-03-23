//
//  View.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import SwiftUI

struct MessageRow: View {
    let message: Message
    @Binding var selectedMessage: Message?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(message.from.name)
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundStyle(.msgFrom)
            Spacer(minLength: 5)
            Text(message.subject)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(.msgSub)
            Spacer(minLength: 5)
            Text(message.snippet!)
                .font(.system(size: 12))
                .lineLimit(2)
                .truncationMode(.tail)
                .foregroundStyle(.msgBody)
        }
        .padding(8)
        .listRowInsets(EdgeInsets())
        .contentShape(Rectangle(), eoFill: true)
        .ignoresSafeArea()
    }
}

