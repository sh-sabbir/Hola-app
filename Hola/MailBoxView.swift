//
//  MailBoxView.swift
//  Hola
//
//  Created by Sabbir Hasan on 29/2/24.
//

import SwiftUI
import SwiftData

struct MailBoxView: View {
    @StateObject var viewModel = MessagesViewModel()
    @State private var selectedMessage: Message? = nil
    
    var body: some View {
        HStack(spacing: 0){
            VStack(alignment: .leading, spacing: 0){
                Text("Inbox")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 13.5)
                Divider()
                List(viewModel.messages, id: \.id) { message in
                    MessageRow(message: message,  selectedMessage: $selectedMessage)
                        .contentShape(Rectangle())
                        .listRowInsets(EdgeInsets())
                        .ignoresSafeArea()
                        .onTapGesture {
                            selectedMessage = message
                            viewModel.fetchMessageDetail(for: message.id)
                        }
                }
                .ignoresSafeArea()
                .contentMargins(0)
                .padding(0)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .onAppear {
                    viewModel.fetchMessages()
                }
            }
            .frame(width: 300)
            
            Divider().ignoresSafeArea()
            
            Section{
                if let selectedMessage = viewModel.selectedMessageDetail {
                    MessageDetailView(message:selectedMessage)
                } else {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MailBoxView()
}
