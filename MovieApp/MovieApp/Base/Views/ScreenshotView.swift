//
//  ScreenshotView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import SwiftUI

struct ScreenshotView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var imageModel: MovieImageModel
    @State var image: UIImage = UIImage()
    @State var isLoading = true
    
    init(model: MovieImageModel) {
        self.imageModel = model
        imageLoader = ImageLoader(url: "https://image.tmdb.org/t/p/w500" + (model.filePath ?? ""))
    }
    
    var body: some View {
        ZStack {
            ActivityIndicator(isAnimating: $isLoading)
                .frame(width: 50, height: 50)
            Image(uiImage: image)
                .resizable()
                .aspectRatio(CGFloat(imageModel.aspectRatio ?? 0), contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 2/3, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                    self.isLoading = false
                }
        }
    }
}
