//
//  TVModel.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import Foundation

// MARK: - TVModel

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

// MARK: - TVDetailModel

struct TVDetailModel: Decodable {
    let backdropPath: String?
    let genres: [Genre]
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasons: [Season]
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id, name, overview
        case posterPath = "poster_path"
        case seasons
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct Season: Decodable {
    let airDate: String?
    let episodeCount, id: Int
    let name, overview: String
    let posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - Credits

struct Credits: Decodable {
    let cast: [Cast]
    let id: Int
}

struct Cast: Decodable {
    let gender, id: Int
    let name, originalName: String
    let profilePath: String?
    let roles: [Role]

    enum CodingKeys: String, CodingKey {
        case gender, id, name
        case originalName = "original_name"
        case profilePath = "profile_path"
        case roles
    }
}

struct Role: Decodable {
    let character: String
}
