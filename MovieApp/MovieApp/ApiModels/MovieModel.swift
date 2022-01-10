//
//  MovieModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import Foundation

struct MovieListResponse: Codable {
    var page: Int
    var results: [MovieModel]
    var totalResults: Int
    var totalPages: Int
    
    init(page: Int, results: [MovieModel], totalResults: Int, totalPages: Int) {
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

struct MovieModel: Codable {
    var id: Int
    var posterPath: String
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Int]
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Float?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Float?
    
    init(
        id: Int,
        posterPath: String,
        adult: Bool,
        overview: String,
        releaseDate: String,
        genreIds: [Int],
        originalTitle: String,
        originalLanguage: String,
        title: String,
        backdropPath: String,
        popularity: Float,
        voteCount: Int,
        video: Bool,
        voteAverage: Float
    ) {
        self.id = id
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case posterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case voteAverage = "vote_average"
    }
}
