//
//  VideoModel.swift
//  MovieApp
//
//  Created by Mikita Glavinski on 12/17/21.
//

import Foundation

struct VideoResponse: Codable {
    var id: Int
    var results: [VideoModel]
    
    init(id: Int, results: [VideoModel]) {
        self.id = id
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}

struct VideoModel: Codable {
    var id: String
    var name: String
    var key: String
    var type: String
    var site: String
    
    init(id: String, name: String, key: String, type: String, site: String) {
        self.id = id
        self.name = name
        self.key = key
        self.type = type
        self.site = site
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case key = "key"
        case type = "type"
        case site = "site"
    }
}
