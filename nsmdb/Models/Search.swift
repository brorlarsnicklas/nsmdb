//
//  Movie.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import Foundation

struct SearchResponse: Codable {
    let search: [Search]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Search: Codable, Identifiable {
    let id = UUID()
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
