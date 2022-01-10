//
//  MovieGenre.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import Foundation

struct MovieGenreResponse: Codable {
    var genres: [MovieGenre]
    
    init(genres: [MovieGenre]) {
        self.genres = genres
    }
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}

struct MovieGenre: Codable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
