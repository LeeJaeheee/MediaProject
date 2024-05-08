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
    
    /*
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
     */
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI) async throws -> T {
        
        var url = URLRequest(url: api.endpoint)
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw SeSACError.invalidResponse
        }
        
        guard response.statusCode == 200 else {
            throw SeSACError.invalidResponse
        }
        
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            return data
        } catch {
            throw SeSACError.invalidData
        }
        
    }
    
    func fetchTVModel(apiList: [TMDBAPI]) async throws -> [[TVResult]] {
        
        return try await withThrowingTaskGroup(of: TVModel.self) { group in
            
            for api in apiList {
                group.addTask {
                    try await self.request(type: TVModel.self, api: api)
                }
            }
            
            var resultList: [[TVResult]] = []
            for try await item in group {
                resultList.append(item.results)
            }
            
            return resultList
            
        }
    }
    
}
