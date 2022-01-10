//
//  MoviePosterView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import SwiftUI

struct MoviePosterView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var imageModel: DetailMovieModel
    @State var image: UIImage = UIImage()
    @State var isLoading = true
    
    init(model: DetailMovieModel) {
        self.imageModel = model
        imageLoader = ImageLoader(url: "https://image.tmdb.org/t/p/original" + (model.backdropPath ?? ""))
    }
    
    var body: some View {
        ZStack {
            ActivityIndicator(isAnimating: $isLoading)
                .frame(width: 50, height: 50)
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                    self.isLoading = false
                }
        }
    }
}
