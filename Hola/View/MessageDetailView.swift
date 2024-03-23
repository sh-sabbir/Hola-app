//
//  MessageDetailView.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import SwiftUI

struct MessageDetailView: View {
    let message: Message
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top){
                VStack(alignment: .leading,spacing: 15) {
                    Text(message.subject)
                        .font(.system(size: 24,weight: .medium))
                    
                    HStack(spacing:16){
                        Text("\(message.created)")
                            .font(.system(size: 12,weight: .regular))
                        Text("\(message.formattedSize())")
                            .font(.system(size: 12,weight: .regular))
                    }
                }
                Spacer()
                HStack{
                    Button("Sign In", systemImage: "arrow.up",action: {
                        print("record clicked")
                    }).labelStyle(.iconOnly)
                    
                    Button("Sign In", systemImage: "arrow.up",action: {
                        print("record clicked")
                    }).labelStyle(.iconOnly)
                    
                    Button("Sign In", systemImage: "arrow.up",action: {
                        print("record clicked")
                    }).labelStyle(.iconOnly)
                }
            }
            Spacer()
                .frame(height: 14.0)
            VStack(alignment: .leading){
                Grid(alignment: Alignment.topLeading) {
                    GridRow {
                        Text("From")
                        Text("\(message.from.name) <\(message.from.address)>")
                    }
                    Divider()
                    GridRow {
                        Text("To")
                        Text("\(message.from.name) <\(message.from.address)>")
                    }
                    Divider()
                    GridRow {
                        Text("Message ID")
                        Text(message.messageID)
                    }
                    Divider()
                    GridRow {
                        Text("Attachments")
                        Text("")
                    }
                }
            }
            .padding()
            .overlay(
                    RoundedRectangle(cornerRadius: 8, style: RoundedCornerStyle.continuous)
                        .stroke(.msgBorder, lineWidth: 1)
                )
            
            Spacer()
                .frame(height: 14.0)
            
            // Custom tab bar
            HStack() {
                HolaTab(index: 0, name: "HTML", isSelected: selectedTab == 0) {
                    self.selectedTab = 0
                }
                HolaTab(index: 1, name: "HTML Source", isSelected: selectedTab == 1) {
                    self.selectedTab = 1
                }
                HolaTab(index: 2, name: "Text", isSelected: selectedTab == 2) {
                    self.selectedTab = 2
                }
                HolaTab(index: 3, name: "Raw", isSelected: selectedTab == 3) {
                    self.selectedTab = 3
                }
                HolaTab(index: 4, name: "Headers", isSelected: selectedTab == 4) {
                    self.selectedTab = 4
                }
                HolaTab(index: 5, name: "Links", isSelected: selectedTab == 5) {
                    self.selectedTab = 5
                }
                HolaTab(index: 6, name: "Spam Report", isSelected: selectedTab == 6) {
                    self.selectedTab = 6
                }
                HolaTab(index: 7, name: "Testing", isSelected: selectedTab == 7) {
                    self.selectedTab = 7
                }
                Spacer()
            }
            
            Spacer()
                .frame(height: 14.0)
            
            // Content area
            tabContent()
            
            Spacer()
        }
        .padding([.leading, .bottom, .trailing], 40.0)
    }
    
    // Content for each tab based on the selected tab index
    @ViewBuilder
    func tabContent() -> some View {
        if selectedTab == 0 {
            MessagePreview(html: message.html ?? "")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        } else if selectedTab == 1 {
            ScrollView(.vertical){
                Text(message.html ?? "")
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
            
        } else {
            Text("Profile Content")
        }
    }
}



struct HolaTab: View {
    let index: Int
    let name: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(name)
                .font(.headline)
                .foregroundColor(isSelected ? .blue : .gray)
        }
        .frame(alignment: .leading)
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMessage = Message(
            id: "1",
            messageID: "123",
            inbox: "Inbox",
            read: true,
            from: Person(name: "John Doe", address: "john.doe@example.com"),
            to: [Person(name: "Jane Smith", address: "jane.smith@example.com")],
            cc: [],
            bcc: [],
            replyTo: [],
            subject: "Sample Subject",
            created: "2024-03-18T23:17:00+06:00",
            returnPath: "no.reply@example.com",
            tags: [],
            size: 100,
            snippet: "This is a sample snippet",
            text: nil,
            html: nil,
            attachments: nil,
            inline: nil
        )
        return MessageDetailView(message: sampleMessage).frame(width: 940,height: 740)
    }
}
