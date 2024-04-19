//
//  PosterView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//

import SwiftUI

struct PosterView: View {
    var poster: String
    var width: CGFloat?
    var height: CGFloat?
    var body: some View {
        AsyncImage(url: URL(string: poster) ) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            if poster == "N/A" {
                Text("N/A")
                    .frame(width: width, height: height)
                    .background(.gray)
            } else {
                ProgressView()
            }
        }.frame(width: width, height: height)
    }
}
