//
//  ActorImageView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import SwiftUI

struct ActorImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()
    @State var isLoading = true
    
    init(path: String) {
        imageLoader = ImageLoader(url: "https://image.tmdb.org/t/p/w500" + path)
    }
    
    var body: some View {
        ZStack {
            ActivityIndicator(isAnimating: $isLoading)
                .frame(width: 50, height: 50)
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                    self.isLoading = false
                }
        }
    }
}
