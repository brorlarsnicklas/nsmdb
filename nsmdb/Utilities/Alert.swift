//
//  Alert.swift
//  nsmdb
//
//  Created by Nicklas Silversved on 2024-04-19.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}


struct AlertContext {
    static let invalidData      = AlertItem(title: Text("Invalid data"), message: Text("Try another search term"), dismissButton: .default(Text("OK")))
    static let invalidResponse  = AlertItem(title: Text("Invalid response"), message: Text("Contact support"), dismissButton: .default(Text("OK")))
    static let invalidURL       = AlertItem(title: Text("Invalid url"), message: Text("Bad url"), dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Server error"), message: Text("Connection error"), dismissButton: .default(Text("OK")))
    static let unexpectedError  = AlertItem(title: Text("Unexpected error"), message: Text("Something went wrong"), dismissButton: .default(Text("OK")))
    
    static let successfullAdd   = AlertItem(title: Text("Thank you!"), message: Text("Successfully added rating"), dismissButton: .default(Text("OK")))
}
