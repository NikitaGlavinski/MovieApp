//
//  VideoView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import SwiftUI

struct VideoView: View {
    
    var movieId: Int
    @ObservedObject var viewModel = VideoViewModel()
    
    init(movieId: Int) {
        self.movieId = movieId
        self.viewModel.getVideo(movieId: self.movieId)
    }
    
    var body: some View {
        WebViewRepresentable(videoID: viewModel.videoModel.key)
            .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
            .cornerRadius(12)
            .padding(.horizontal, 24)
            .alert(isPresented: $viewModel.error.isShown) {
                Alert(title: Text("Error"), message: Text(viewModel.error.message), dismissButton: .default(Text("Ok")))
            }
    }
}
