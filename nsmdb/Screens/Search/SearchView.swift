//
//  SearchView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    @State private var pageCount = 1
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to NSMDB")
                    .bold()
                    .font(.largeTitle)
                Text("Search for your favorite movie or series and give it the rating it deserves.")
                    .padding()
                TextField("Enter a movie or series title...", text: $searchText)
                    .onChange(of: searchText, initial: true) { oldString, newString in
                        if newString.isEmpty, !oldString.isEmpty {
                            viewModel.resetSearchItems()
                            pageCount = 1
                        }
                    }
                    .onSubmit {
                        viewModel.searchItems(searchString: searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                    .disableAutocorrection(true)
                
                List(viewModel.searchedItems) { searchItem in
                    NavigationLink(destination: DetailsView(imdbID: searchItem.imdbID)) {
                        HStack{
                            PosterView(poster: searchItem.poster, width: 44, height: 44)
                        }
                        VStack (alignment: .leading) {
                            Text(searchItem.title)
                                .font(.headline)
                            Text("Year: \(searchItem.year)")
                                .font(.subheadline)
                            Text(searchItem.type.capitalized)
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                if !viewModel.searchedItems.isEmpty && !viewModel.isFinished {
                    Button(action: {
                        pageCount += 1
                        viewModel.searchItems(searchString: searchText, page: pageCount)
                    }) {
                        NSButtonView(title: "Load more", textColor: Color(.label), backgroundColor: .yellow)
                    }.padding()
                }
            }
        }.alert(item: $viewModel.alertItem) {
            alertItem in Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}


#Preview {
    SearchView()
}
