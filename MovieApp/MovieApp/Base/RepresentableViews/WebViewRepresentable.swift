//
//  WebViewRepresentable.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    let videoID: String
    
    func makeUIView(context: Context) -> UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: url))
    }
}
