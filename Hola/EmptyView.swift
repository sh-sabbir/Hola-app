//
//  EmptyView.swift
//  Hola
//
//  Created by Sabbir Hasan on 6/3/24.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        GeometryReader { geometry in
            HolaFull()
                .foregroundColor(.watermark)
                .frame(width: 300.0, height: 148)
                .position(x:geometry.size.width/2,y: geometry.size.height/2)
        }
    }
}

#Preview {
    EmptyView()
}
