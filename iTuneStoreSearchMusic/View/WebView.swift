//
//  WebView.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 14.10.22.
//

import Foundation

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        print("update WebView")
    }
    
    
}
