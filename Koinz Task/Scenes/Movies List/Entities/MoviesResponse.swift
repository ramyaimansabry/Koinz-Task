//
//  MoviesResponse.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int?
    let results: [MovieData]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
