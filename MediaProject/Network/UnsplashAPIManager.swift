//
//  UnsplashAPIManager.swift
//  MediaProject
//
//  Created by 이재희 on 2/12/24.
//

import Foundation
import Alamofire

class UnsplashAPIManager {
    
    static let shared = UnsplashAPIManager()
    
    func request<T: Decodable>(type: T.Type, api: UnsplashAPI, completionHandler: @escaping (T?, AFError?) -> Void) {
        AF.request(api.endpoint, parameters: api.parameter, headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                print(failure)
            }
        }

    }
    
}
