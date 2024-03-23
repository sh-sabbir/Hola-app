//
//  MessagePreview.swift
//  Hola
//
//  Created by Sabbir Hasan on 23/3/24.
//

import SwiftUI
import WebKit

struct MessagePreview: NSViewRepresentable {
    let html: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsLinkPreview = true
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: nil)
    }
}

#Preview {
    MessagePreview(html:"<h1>Hello World</h1>")
}
