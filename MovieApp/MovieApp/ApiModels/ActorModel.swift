//
//  ActorModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import Foundation

struct ActorListResponse: Codable {
    var page: Int
    var results: [ActorModel]
    var totalResults: Int
    var totalPages: Int
    
    init(page: Int, results: [ActorModel], totalResults: Int, totalPages: Int) {
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct ActorModel: Codable {
    var id: Int
    var photoPath: String?
    var adult: Bool?
    var name: String?
    var popularity: Float?
    var movies: [MovieModel]?
    
    init(id: Int, photoPath: String, adult: Bool, name: String, popularity: Float, movies: [MovieModel]) {
        self.id = id
        self.photoPath = photoPath
        self.adult = adult
        self.name = name
        self.popularity = popularity
        self.movies = movies
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photoPath = "profile_path"
        case adult = "adult"
        case name = "name"
        case popularity = "popularity"
        case movies = "known_for"
    }
}
