//
//  MessageDetailView.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import SwiftUI
import HighlightSwift
import SwiftSoup

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
            .overlay(RoundedRectangle(cornerRadius: 8, style: RoundedCornerStyle.continuous)
                    .stroke(.msgBorder, lineWidth: 1))
            
            Spacer()
                .frame(height: 14.0)
            
            // Custom tab bar
            HStack(spacing:16) {
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
    
    private func indentHTML(_ htmlString: String) -> String {
        do {
            let doc: Document = try SwiftSoup.parse(htmlString)
            let cleanHtml: String = try doc.outerHtml()
            return cleanHtml
        } catch Exception.Error(_, let message) {
            return message
        } catch {
            return ""
        }
    }
    
    // Content for each tab based on the selected tab index
    @ViewBuilder
    func tabContent() -> some View {
        
        // MARK: - HTML Preview
        if selectedTab == 0 {
            let msgHTML = (message.html ?? "")
            MessagePreview(html: msgHTML)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        // MARK: - HTML Source Code
        else if selectedTab == 1 {
            ScrollView(.vertical){
                if let textContent = message.html {
                    CodeText(indentHTML(textContent))
                        .codeTextLanguage(.html)
                        .codeTextColors(.theme(.atomOne))
                        .monospaced()
                } else {
                    Text("No HTML content available")
                }
                    
            }
            .padding(16.0)
            .background(RoundedRectangle(cornerRadius: 8, style: RoundedCornerStyle.continuous)
                    .fill(Color.themeSwitchBG))
            
        }
        // MARK: - Email Text version
        else if selectedTab == 2 {
            ScrollView(.vertical){
                if let textContent = message.text {
                    LazyVStack(spacing:0){
                        ForEach(Array(textContent.components(separatedBy: "\r\n").enumerated()), id: \.offset) { index, line in
                            Text(line)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                    }
                }
            }
            .padding(16.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8, style: RoundedCornerStyle.continuous)
                    .fill(Color.themeSwitchBG))
            
        }
        // MARK: - Raw Email
        else if selectedTab == 3 {
            ScrollView(.vertical){
                if let textContent = message.raw {
                    LazyVStack(spacing:0){
                        ForEach(Array(textContent.components(separatedBy: "\r\n").enumerated()), id: \.offset) { index, line in
                            Text(line)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                    }
                }
            }
            .padding(16.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8, style: RoundedCornerStyle.continuous)
                    .fill(Color.themeSwitchBG))
            
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
        .buttonStyle(HolaTabStyle(selectedPage: isSelected))
        .frame(alignment: .leading)
    }
}

struct HolaTabStyle: ButtonStyle {
    var selectedPage: Bool
    @State private var isHovered = false
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
            .padding(.vertical, 8)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedPage ? Color.sidebarTint : Color.clear)
                        
                    if isHovered && !selectedPage {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.sidebarTint.opacity(0.3))
                    }
                }
            )
            .onHover { hovering in
                withAnimation {
                    isHovered = hovering
                }
            }
            .foregroundColor(.primary)
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
            inline: nil,
            raw: nil,
            headers: nil
        )
        return MessageDetailView(message: sampleMessage).frame(width: 940,height: 740)
    }
}
