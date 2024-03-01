//
//  SwiftUIView.swift
//  Hola
//
//  Created by Sabbir Hasan on 28/2/24.
//

import SwiftUI

struct ThemeSwitcherStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Rectangle()
                .foregroundColor(.themeSwitchBG)
                .frame(width: 36, height: 72, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.themeSwitchCircle)
                        .padding(.all, 2)
                        .overlay(
                            Image(systemName: configuration.isOn ? "moon.fill" : "sun.max.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18, alignment: .center)
                                .foregroundColor(.themeSwitchIcon)
                        )
                        .offset(x: 0, y: configuration.isOn ? 18 : -18)
                        .shadow(color: .black.opacity(0.14), radius: 4, x:0, y:2)
                        .animation(Animation.spring(duration: 0.3), value: configuration.isOn)
                        
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
    
}
