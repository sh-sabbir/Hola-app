//
//  ContentView.swift
//  Hola
//
//  Created by Sabbir Hasan on 27/2/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var selected: Int? = nil
    @State private var columnVisibility =
        NavigationSplitViewVisibility.doubleColumn

    var body: some View {
        HStack(spacing:0){
            NavigationStack {
                NavigationLink(
                    destination: Text("Paper Plane"),
                    label: {
                        Image(systemName: "paperplane")
                    }
                )
                NavigationLink(
                    destination: Text("Inbox"),
                    label: {
                        Image(systemName: "tray")
                    }
                )
                
                Spacer()
                
                Toggle("", isOn: $isDarkMode)
                    .foregroundColor(.blue)
                    .toggleStyle(ThemeSwitcherStyle())
                    .padding()
            }
            .frame(width: 90)
            .background(.sidebar)

            
            MailBoxView()
        }
    }
}

#Preview {
    ContentView()
}
