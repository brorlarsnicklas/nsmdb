//
//  DetailsView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import SwiftUI

struct DetailsView: View {
    @State var imdbID: String
    @ObservedObject var viewModel = DetailsViewModel()
    @State private var isModalPresented = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let item = viewModel.item {
                    Text(item.title)
                        .font(.title)
                    HStack {
                        PosterView(poster: item.poster, width: 180)
                        VStack {
                            IconView(icon: "star.fill", title: "\(item.imdbRating)/10", subTitle: "IMDB")
                            Button(action: {
                                isModalPresented = true
                            }) {
                                if let rating = item.userRating {
                                    IconView(icon: "star.fill", title: "\(rating)/10", subTitle: "My rating")
                                } else {
                                    IconView(icon: "star", title: "Rate this?", subTitle: "My rating")
                                }
                            }
                            .padding()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Plot")
                            .font(.subheadline)
                            .bold()
                        Text(item.plot)
                            .font(.subheadline)
                    }
                } else {
                    ProgressView()
                }
                
            }.onAppear {
                getDetails()
            }.sheet(isPresented: $isModalPresented) {
                if viewModel.item != nil {
                    RatingModalView(isModalPresented: $isModalPresented, item: $viewModel.item, viewModel: viewModel)
                }
            }
            .padding()
        }
    }
    
    private func getDetails() {
        viewModel.getItemById(imdbID: imdbID)
    }
}

