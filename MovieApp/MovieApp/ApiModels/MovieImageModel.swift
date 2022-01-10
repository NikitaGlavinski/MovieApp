//
//  MovieImageModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import Foundation

struct MovieImagesResponse: Codable {
    var id: Int
    var backdrops: [MovieImageModel]
    var posters: [MovieImageModel]
    
    init(id: Int, backdrops: [MovieImageModel], posters: [MovieImageModel]) {
        self.id = id
        self.backdrops = backdrops
        self.posters = posters
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case backdrops = "backdrops"
        case posters = "posters"
    }
}

struct MovieImageModel: Codable {
    var aspectRatio: Float?
    var filePath: String?
    var height: Int?
    var width: Int?
    
    init(aspectRatio: Float, filePath: String, height: Int, width: Int) {
        self.aspectRatio = aspectRatio
        self.filePath = filePath
        self.height = height
        self.width = width
    }
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height = "height"
        case width = "width"
    }
}
