//
//  UnsplashAPI.swift
//  MediaProject
//
//  Created by 이재희 on 2/12/24.
//

import Foundation
import Alamofire

enum UnsplashAPI {
    case search(query: String)
    
    var baseURL: String { "https://api.unsplash.com/" }
    var header: HTTPHeaders { ["Authorization": APIKey.unsplash] }
    var method: HTTPMethod { .get }
    var parameter: Parameters { ["language": "ko-KR"] }
    
    var endpoint: URL {
        switch self {
        case .search(let query):
            URL(string: baseURL + "search/photos?page=1&query=\(query)")!
        }
    }
    
}
