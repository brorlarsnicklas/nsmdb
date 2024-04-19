//
//  Movie.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import Foundation


struct SearchItem: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let year: String
    let poster: String
    let searchType: String
    let imdbRating: String
    let plot: String
    var userRating: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case searchType = "Type"
        case poster = "Poster"
        case plot = "Plot"
        case userRating
        case imdbRating
        case id = "imdbID"
    }
}
