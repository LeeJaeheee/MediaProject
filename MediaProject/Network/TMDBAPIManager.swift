//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    static let share = TMDBAPIManager()
    
    let baseURL = "https://api.themoviedb.org/3/"
    let language = "ko-KR"
    
    func fetchTV(url: String, completionHandler: @escaping ([TVResult]) -> Void) {
        let url = baseURL + url
        let parameter: Parameters = ["language": language]
        let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
        
        AF.request(url, parameters: parameter, headers: header).responseDecodable(of: TVModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }

    }
    
}
