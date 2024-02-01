//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
//    let baseURL = "https://api.themoviedb.org/3/"
//    let parameter: Parameters = ["language": "ko-KR"]
//    let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
    
    func fetchTV(api: TMDBAPI, completionHandler: @escaping ([TVResult]) -> Void) {

        AF.request(api.endpoint, parameters: api.parameter, headers: api.header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }

    }
    
    func fetchTVDetail(api: TMDBAPI, completionHandler: @escaping (TVDetailModel) -> Void) {
        AF.request(api.endpoint, parameters: api.parameter, headers: api.header).responseDecodable(of: TVDetailModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchCredits(api: TMDBAPI, completionHandler: @escaping ([Cast]) -> Void) {
        AF.request(api.endpoint, parameters: api.parameter, headers: api.header).responseDecodable(of: Credits.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.cast)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
