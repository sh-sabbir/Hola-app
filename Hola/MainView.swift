//
//  MainView.swift
//  Hola
//
//  Created by Sabbir Hasan on 4/3/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var selectedPage: String?
    
    var body: some View {

        HStack(alignment: .top, spacing: 0) {
            Section {
                VStack{
                    HolaFull()
                        .foregroundColor(.sidebarAccentMono)
                        .frame(width: 44.0, height: 21.70)
                        .padding(.top, 8)
                    List {
                        SidebarItem(label: "Mailbox", systemImage: "tray.fill", selectedPage: $selectedPage)
                                            
                        SidebarItem(label: "Saved", systemImage: "square.and.arrow.down.fill", selectedPage: $selectedPage)
                                       
                        Divider()
                        
                        SidebarItem(label: "Help", systemImage: "questionmark.circle", selectedPage: $selectedPage)
                    }
                    .listStyle(.plain)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .contentMargins(0)
                    .padding(.top, 16)
                    .onAppear{
                        Task { @MainActor in
                            try await Task.sleep(for: .seconds(0.05))
                            selectedPage = "mailbox"
                        }
                    }
                
                    Spacer()

                    Toggle("", isOn: $isDarkMode)
                        .foregroundColor(.blue)
                        .toggleStyle(ThemeSwitcherStyle())
                        .padding()
                }
            }
            .frame(width: 76)
            .background(.sidebar)
            
            Divider().ignoresSafeArea()
            
            Section {
                switch selectedPage {
                case "mailbox":
                    MailBoxView()
                case "saved":
                    Text("Saved page selected")
                case "help":
                    Text("Help page selected")
                default:
                    Text("Unknown page selected")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.sidebar)
    }
}


struct SidebarItem: View {
    let label: String
    let systemImage: String
    @Binding var selectedPage: String?
    @State private var isHovered = false
    
    var body: some View {
        Button(action: {
            selectedPage = label.lowercased()
        }) {
            Image(systemName: systemImage)
                .font(.system(size: 20, weight: .regular))
                .frame(width: 76, height: 46.0)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 2, leading: -8, bottom: 2, trailing: -8))
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(selectedPage == label.lowercased() ? Color.sidebarTint : Color.clear)
                Rectangle()
                    .fill(selectedPage == label.lowercased() ? Color.sidebarAccent : Color.clear)
                    .frame(width: 2.0)
                    .position(x:1, y:23)
                    
                if isHovered && selectedPage != label.lowercased() {
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 37.0, height: 37.0)
                        .position(x: 38, y: 23)
                }
            }
        )
        .foregroundColor(textColor)
        .onHover { hovering in
            withAnimation {
                isHovered = hovering
            }
        }
    }
    
    private var textColor: Color {
        if isHovered {
            return .sidebarAccent // Change color when hovered
        } else if selectedPage == label.lowercased() {
            return .sidebarAccent // Change color when selected
        } else {
            return .sidebarItem // Default color
        }
    }
}

#Preview {
    MainView()
}
