//
//  TVModel.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import Foundation

struct TVModel: Decodable {
    let results: [TVResult]
}

struct TVResult: Decodable {
    let id: Int
    let name: String
    let overview: String
    let backdrop: String?
    let poster: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

