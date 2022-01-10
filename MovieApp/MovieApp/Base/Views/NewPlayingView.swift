//
//  NewPlayingView.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import SwiftUI

struct NewPlayingView: View {
    
    var model: MovieModel
    
    var body: some View {
        VStack(alignment: .leading , spacing: 5) {
            NewPlayingImage(path: model.backdropPath ?? "")
            Text(model.title ?? "")
                .font(.system(size: 12, weight: .regular, design: .default))
                .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 0))
                .lineLimit(1)
            HStack(spacing: 7) {
                ForEach(0..<Int((model.voteAverage ?? 0) / 2)) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.yellow)
                }
                Text("\(String(format: "%g", Float(round(10 * (model.voteAverage ?? 0)) / 10)))")
                    .lineLimit(1)
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 5)
        }
    }
}
