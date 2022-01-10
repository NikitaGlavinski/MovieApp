//
//  DetailMovieModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/16/21.
//

import SwiftUI

struct DetailMovieModel: Codable {
    var id: Int
    var title: String
    var releaseDate: String
    var runTime: Int?
    var budget: Int
    var backdropPath: String?
    var overview: String?
    
    init(
        id: Int,
        title: String,
        releaseDate: String,
        runTime: Int,
        budget: Int,
        backdropPath: String,
        overview: String
    ) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.runTime = runTime
        self.budget = budget
        self.backdropPath = backdropPath
        self.overview = overview
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case runTime = "runtime"
        case budget = "budget"
        case backdropPath = "backdrop_path"
        case overview = "overview"
    }
}
