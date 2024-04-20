//
//  SearchViewModel.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var searchedItems: [Search] = []
    @Published var item: SearchItem?
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isFinished = false
    
    func searchItems(searchString: String, page: Int = 1) {
        isLoading = true
        NetworkManager.shared.searchItems(searchString: searchString, page: page) {
            result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let search):
                    if search.isEmpty {
                        self.isFinished = true
                    } else {
                        self.searchedItems.append(contentsOf: search)
                    }
                case .failure( let error ):
                    self.isFinished = true
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    default:
                        self.alertItem = AlertContext.unexpectedError
                    }
                }
            }
        }
    }
    
    func resetSearchItems() {
        self.searchedItems = []
        self.isFinished = false
    }
}
