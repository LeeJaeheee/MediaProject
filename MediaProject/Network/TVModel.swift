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
    
    let voteCountString: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.backdrop = try container.decodeIfPresent(String.self, forKey: .backdrop)
        self.poster = try container.decodeIfPresent(String.self, forKey: .poster)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.voteCountString = String(format: "%.1f", voteAverage) + " (\(voteCount > 999 ? "999+" : "\(voteCount)"))"
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
    
    let convertedOverview: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id, name, overview
        case posterPath = "poster_path"
        case seasons
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.seasons = try container.decode([Season].self, forKey: .seasons)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.convertedOverview = overview.isEmpty ? "줄거리를 제공하지 않습니다." : overview
    }
    
    init() {
        self.backdropPath = nil
        self.genres = []
        self.id = 0
        self.name = ""
        self.overview = ""
        self.posterPath = nil
        self.seasons = []
        self.voteAverage = 0.0
        self.voteCount = 0
        self.convertedOverview = ""
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

struct CreditModel: Decodable {
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
