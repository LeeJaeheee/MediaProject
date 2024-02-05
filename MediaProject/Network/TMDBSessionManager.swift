//
//  TMDBSessionManager.swift
//  MediaProject
//
//  Created by 이재희 on 2/5/24.
//

import Foundation

enum SeSACError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TMDBSessionManager {
    
    static let shared = TMDBSessionManager()
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T?, SeSACError?) -> Void) {
        
        var url = URLRequest(url: api.endpoint)
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completionHandler(nil, .invalidData)
                    return
                }
                
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(data, nil)
                } catch {
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume()
    }
}
