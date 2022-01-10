//
//  ActivityIndicator.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/15/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.tintColor = .black
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
