//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import Foundation
import Alamofire

enum MediaType: String {
    case all
    case movie
    case tv
}

enum TMDBAPI: Equatable {
    //TODO: 연관값 추가해서 미디어타입 정해주기
    case trending
    case topRated
    case popular
    case Overview(id: Int)
    case Cast(id: Int)
    case Recommendation(id: Int)
    case video(id: Int)
    
    static var imageBaseURL: String { "https://image.tmdb.org/t/p/w500" }
    var baseURL: String { "https://api.themoviedb.org/3/" }
    var header: HTTPHeaders { ["Authorization": APIKey.tmdb] }
    var method: HTTPMethod { .get }
    var parameter: Parameters { ["language": "ko-KR"] }
    
    var endpoint: URL {
        switch self {
        case .trending:
            URL(string: baseURL + "trending/movie/day")!
        case .topRated:
            URL(string: baseURL + "movie/top_rated")!
        case .popular:
            URL(string: baseURL + "movie/popular")!
        case .Overview(let id):
            URL(string: baseURL + "movie/\(id)")!
        case .Cast(let id):
            URL(string: baseURL + "movie/\(id)/credits")! //tv: aggregated_credits
        case .Recommendation(let id):
            URL(string: baseURL + "movie/\(id)/recommendations")!
        case .video(id: let id):
            URL(string: baseURL + "movie/\(id)/videos")!
        }
    }
    
    var title: String {
        switch self {
        case .trending:
            return "추천 TV 콘텐츠"
        case .topRated:
            return "TOP 20 TV 콘텐츠"
        case .popular:
            return "인기 TV 콘텐츠"
        case .Overview:
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
        case .Overview:
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
