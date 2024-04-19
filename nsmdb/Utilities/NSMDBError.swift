//
//  NSMDBError.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import Foundation

enum NSMDBError: String, Error {
    case invalidURL                 = "There was something wrong with the url."
    case invalidResponse            = "Invalid response from server. Please try again."
    case invalidData                = "The data received from the server was invalid. Please try again."
    case unableToComplete           = "Couldn't complete the request, check your connection."
    case unableToFetchFromStorage   = "Couldn't fetch the data from storage. Please try again."
    case unableToStoreRatings       = "Unable to store ratings. Please try again."
    case ratingAlreadyStored        = "This rating is already added to storage."
}
