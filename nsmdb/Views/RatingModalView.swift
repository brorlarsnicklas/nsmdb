//
//  AddRatingView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//
import SwiftUI

struct RatingModalView: View {
    @Binding var isModalPresented: Bool
    @Binding var item: SearchItem?
    @ObservedObject var viewModel: DetailsViewModel
    
    
    var body: some View {
        VStack {
            Spacer()
            if let unwrappedItem = item {
                Text(unwrappedItem.title.capitalized)
                    .font(.title)
                    .padding()
                Text("My rating \(unwrappedItem.userRating ?? 0) / 10")
                    .padding()
                HStack {
                    ForEach(1 ..< 11) { index in
                        Button(action: {
                            if var updatedItem = item {
                                updatedItem.userRating = index
                                self.item = updatedItem
                            }
                        }) {
                            Image(systemName: index <= unwrappedItem.userRating ?? 0 ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                Button(action: {
                    viewModel.isLoading = true
                    if let unwrappedItem = item, viewModel.ratings.contains(where: { $0.id == unwrappedItem.id }) {
                        viewModel.updateRating(unwrappedItem)
                    } else {
                        viewModel.addItemToStore(unwrappedItem)
                    }
                }) {
                    NSButtonView(title: "Add rating", textColor: Color(.label), backgroundColor: .yellow)
                }
                .padding()
                Spacer()
                Button (action: {
                    isModalPresented = false
                }) {
                    Text("Close")
                        .foregroundColor(Color(.label))
                }
            }
        }
        .padding()
        .alert(item: $viewModel.alertItem) {
            alertItem in Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
