//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import Foundation
import Alamofire

// TODO: Equatable 나중에 테이블뷰셀마다 높이 다르게 하는거 성공하고 나면 지우기..
enum TMDBAPI: Equatable {
    
    case trending
    case topRated
    case popular
    case Overview(id: Int)
    case Cast(id: Int)
    case Recommendation(id: Int)
    
    static var imageBaseURL: String { "https://image.tmdb.org/t/p/w500" }
    var baseURL: String { "https://api.themoviedb.org/3/" }
    var header: HTTPHeaders { ["Authorization": APIKey.tmdb] }
    var method: HTTPMethod { .get }
    var parameter: Parameters { ["language": "ko-KR"] }
    
    var endpoint: String {
        switch self {
        case .trending:
            baseURL + "trending/tv/day"
        case .topRated:
            baseURL + "tv/top_rated"
        case .popular:
            baseURL + "tv/popular"
        case .Overview(let id):
            baseURL + "tv/\(id)"
        case .Cast(let id):
            baseURL + "tv/\(id)/aggregate_credits"
        case .Recommendation(let id):
            baseURL + "tv/\(id)/recommendations"
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
        }
    }
}