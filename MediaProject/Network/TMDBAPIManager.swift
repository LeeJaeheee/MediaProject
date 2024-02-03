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
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T) -> Void) {
        AF.request(api.endpoint, parameters: api.parameter, headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }

    }
    
}
