//
//  GenreButton.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import SwiftUI

struct GenreButton: View {
    
    @Binding var selectedId: Int
    var viewModel: ContentViewModel
    var genreModel: MovieGenre
    
    var body: some View {
        Button {
            selectedId = genreModel.id
            viewModel.filterByGenre(genreId: genreModel.id)
        } label: {
            Text(genreModel.name)
                .font(.system(size: 13, weight: .regular, design: .default))
                .padding(EdgeInsets(top: 10, leading: 4, bottom: 10, trailing: 4))
                .frame(width: 90)
                .lineLimit(1)
                .background(selectedId == genreModel.id ? Color.gray : Color.white)
                .foregroundColor(selectedId == genreModel.id ? .white : .gray)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(Color.gray, lineWidth: 1.0)
                )
        }
        .clipShape(Capsule())
    }
}
