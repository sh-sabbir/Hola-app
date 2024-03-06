//
//  ContentView.swift
//  Hola
//
//  Created by Sabbir Hasan on 27/2/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var selectedPage: String?
    @State private var columnVisibility = NavigationSplitViewVisibility.all

    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            VStack{
                List(selection: $selectedPage)  {
                    NavigationLink(value: "mailbox"){
                        Label("Mailbox", systemImage: "tray.fill")
                            .labelStyle(.iconOnly)
                            .frame(width: 50.0)
                    }
                    .frame(height: 48.0)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    
                    NavigationLink(value: "favorite"){
                        Label("Saved", systemImage: "square.and.arrow.down.fill")
                            .labelStyle(.iconOnly)
                            .frame(width: 50.0)
                    }
                    .frame(height: 48.0)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    
                    Divider()
                        .frame(width: 52.0)
                    
                    NavigationLink(value: "help"){
                        Label("Help", systemImage: "questionmark.circle")
                            .labelStyle(.iconOnly)
                            .frame(width: 50.0)
                    }
                    .frame(height: 48.0)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .accentColor(.purple)
                }
                .listItemTint(/*@START_MENU_TOKEN@*/.monochrome/*@END_MENU_TOKEN@*/)
                .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
            .background(.sidebar)
            .navigationSplitViewColumnWidth(84)
        } content: {
            Text("Content")
        } detail: {
            /*@START_MENU_TOKEN@*/Text("Detail")/*@END_MENU_TOKEN@*/
        }
        .navigationSplitViewStyle(.balanced)
        .background(.sidebar)
        .listSectionSeparatorTint(.green)
    }
        
}

#Preview {
    ContentView()
}
