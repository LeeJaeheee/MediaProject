//
//  UnsplashModel.swift
//  MediaProject
//
//  Created by 이재희 on 2/12/24.
//

import Foundation

struct UnsplashSearchModel: Decodable {
    let total, totalPages: Int
    let results: [UnsplashSearchResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct UnsplashSearchResult: Decodable {
    let id: String
    let urls: UnsplashSearchUrls
}


struct UnsplashSearchUrls: Decodable {
    let thumb: String
}
