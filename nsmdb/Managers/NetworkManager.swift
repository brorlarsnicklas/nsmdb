//
//  NetworkManager.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import Foundation


final class NetworkManager {
    static let shared = NetworkManager()
    private let superSecret = "ADD YOUR KEY"
    private let searchURL: String
    
    private init() {
        self.searchURL = "https://www.omdbapi.com/?apikey=" + superSecret
    }
    
    func searchItems(searchString: String, page: Int, completed: @escaping (Result<[Search], NSMDBError>) -> Void) {
        guard let url = URL(string: (searchURL + "&s=\(searchString.lowercased())&page=\(page)" )) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(SearchResponse.self, from: data)
                completed(.success(decodedResponse.search))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getItemById(id: String, completed: @escaping (Result<SearchItem, NSMDBError>) -> Void) {
        guard let url = URL(string: (searchURL + "&i=\(id.lowercased())" )) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(SearchItem.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
    
