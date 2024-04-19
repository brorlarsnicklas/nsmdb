//
//  DetailsViewModel.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//

import SwiftUI

final class DetailsViewModel: ObservableObject {
    @Published var item: SearchItem?
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var ratings: [SearchItem] = []
        
    func getItemById(imdbID: String) {
        isLoading = true
        PersistenceManager.getRatings { result in
            switch result {
            case .success(let ratings):
                self.ratings = ratings
                if !ratings.isEmpty, let item = ratings.first(where: { $0.id == imdbID }) {
                    self.item = item
                } else {
                    NetworkManager.shared.getItemById(id: imdbID) {
                        result in
                        DispatchQueue.main.async {
                            self.isLoading = false
                            switch result {
                            case .success(let item):
                                self.item = item
                            case .failure( let error ):
                                print("error", error)
                            }
                            
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addItemToStore(_ item: SearchItem) {
        PersistenceManager.updateRatings(item: item, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                self.alertItem = AlertContext.unexpectedError
            } else {
                self.alertItem = AlertContext.successfullAdd
            }
            self.isLoading = false
        }
    }
    
    func updateRating(_ item: SearchItem) {
        PersistenceManager.updateRatings(item: item, actionType: .update) { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                self.alertItem = AlertContext.unexpectedError
            } else {
                self.alertItem = AlertContext.successfullAdd
            }
            self.isLoading = false
        }
    }
    
}
