//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import Foundation
import Alamofire

enum MediaType: Int, CaseIterable {
    case movie
    case tv
    case all
    
    var caseString: String {
        switch self {
        case .movie:
            return "movie"
        case .tv:
            return "tv"
        case .all:
            //TODO: 나중에 고치기...
            return "tv"
        }
    }
    
    var title: String {
        switch self {
        case .movie:
            return "영화"
        case .tv:
            return "TV"
        case .all:
            return ""
        }
    }
}

enum TMDBAPI: Equatable {
    case trending(type: MediaType)
    case topRated(type: MediaType)
    case popular(type: MediaType)
    case Details(type: MediaType, id: Int)
    case Cast(type: MediaType, id: Int)
    case Recommendation(type: MediaType, id: Int)
    case video(type: MediaType, id: Int)
    
    static var imageBaseURL: String { "https://image.tmdb.org/t/p/w500" }
    var baseURL: String { "https://api.themoviedb.org/3/" }
    var header: HTTPHeaders { ["Authorization": APIKey.tmdb] }
    var method: HTTPMethod { .get }
    var parameter: Parameters { ["language": "ko-KR"] }
    
    var endpoint: URL {
        switch self {
        case .trending(let type):
            URL(string: baseURL + "trending/\(type.caseString)/day")!
        case .topRated(let type):
            URL(string: baseURL + "\(type.caseString)/top_rated")!
        case .popular(let type):
            URL(string: baseURL + "\(type.caseString)/popular")!
        case .Details(let type, let id):
            URL(string: baseURL + "\(type.caseString)/\(id)")!
        case .Cast(let type, let id):
            URL(string: baseURL + "\(type.caseString)/\(id)/\(type == .movie ? "credits" : "aggregate_credits")")! //tv: aggregate_credits
        case .Recommendation(let type, let id):
            URL(string: baseURL + "\(type.caseString)/\(id)/recommendations")!
        case .video(let type, let id):
            URL(string: baseURL + "\(type.caseString)/\(id)/videos")!
        }
    }
    
    var title: String {
        switch self {
        case .trending(let type):
            return "추천 \(type.title) 콘텐츠"
        case .topRated(let type):
            return "TOP 20 \(type.title) 콘텐츠"
        case .popular(let type):
            return "인기 \(type.title) 콘텐츠"
        case .Details:
            return "줄거리"
        case .Cast:
            return "출연"
        case .Recommendation:
            return "추천 콘텐츠"
        default:
            return ""
        }
    }
    
    var responseType: Decodable.Type {
        switch self {
        case .trending:
            return TVModel.self
        case .topRated:
            return TVModel.self
        case .popular:
            return TVModel.self
        case .Details:
            return TVDetailModel.self
        case .Cast:
            return CreditModel.self
        case .Recommendation:
            return TVModel.self
        case .video:
            return VideoModel.self
        }
    }
}
