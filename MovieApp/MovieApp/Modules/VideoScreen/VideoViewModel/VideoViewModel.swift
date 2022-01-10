//
//  VideoViewModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import SwiftUI

class VideoViewModel: ObservableObject {
    
    @Published var videoModel: VideoModel = VideoModel(id: "", name: "", key: "", type: "", site: "")
    @Published var error = ErrorView(isShown: false, message: "")
    
    func getVideo(movieId: Int) {
        NetworkService.shared.getMovieVideos(movieId: movieId) { result in
            switch result {
            case .success(let response):
                guard let index = response.results.firstIndex(where: {$0.type == "Trailer" && $0.site == "YouTube"}) else { return }
                DispatchQueue.main.async {
                    self.videoModel = response.results[index]
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = ErrorView(isShown: true, message: error.localizedDescription)
                }
            }
        }
    }
}
