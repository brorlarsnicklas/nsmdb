//
//  NavigationTabsView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-18.
//

import SwiftUI

struct NavigationTabsView: View {
    var body: some View {
    TabView {
            SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
                    .accessibilityLabel("Search for movies or series")
            }
            RatingsView()
            .tabItem {
                Image(systemName: "star.fill")
                Text("Ratings")
                    .accessibilityLabel("My ratings")
            }
        }.accentColor(Color(.label))
    }
}

#Preview {
    NavigationTabsView()
}
