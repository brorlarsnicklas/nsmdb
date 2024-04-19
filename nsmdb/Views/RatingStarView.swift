//
//  RatingStarView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//

import SwiftUI

struct IconView: View {
    var icon: String
    var title: String
    var subTitle: String
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.yellow)
            Text(title)
                .font(.title2)
            Text(subTitle)
                .font(.subheadline)
        }
    }
}
