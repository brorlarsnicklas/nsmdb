//
//  MovieRatingsView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import SwiftUI

struct RatingsView: View {
    @State private var ratings: [SearchItem] = []
    @State private var searchTerm: String = ""
    
    var filteredRatings: [SearchItem] {
        guard !searchTerm.isEmpty else { return ratings}
        return ratings.filter { $0.title.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    var body: some View {
        NavigationView{
            if filteredRatings.isEmpty, ratings.isEmpty {
                Text("No ratings found")
                    .navigationTitle("Ratings")
            } else {
                List {
                    ForEach(filteredRatings) { rating in
                        NavigationLink(destination: DetailsView(imdbID: rating.id)) {
                            HStack {
                                PosterView(poster: rating.poster, height: 70)
                                Text(rating.title.capitalized)
                            }
                        }
                    }
                    .onDelete(perform: removeRating)
                }
                .searchable(text: $searchTerm, prompt: "Search title")
                .disableAutocorrection(true)
                .navigationTitle("Ratings")
            }
        }.onAppear {
            PersistenceManager.getRatings { result in
                switch result {
                case .success(let ratings):
                    self.ratings = ratings.sorted(by: { $0.title < $1.title })
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func removeRating(at offsets: IndexSet) {
        ratings.remove(atOffsets: offsets)
        PersistenceManager.storeRatings(ratings: ratings)
    }
}

#Preview {
    RatingsView()
}
