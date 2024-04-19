//
//  NSButtonView.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//

import SwiftUI

struct NSButtonView: View {
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
