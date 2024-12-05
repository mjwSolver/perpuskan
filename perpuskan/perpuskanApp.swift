//
//  perpuskanApp.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI
import SwiftData

@main
struct perpuskanApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .modelContainer(for: [Book.self, BookCategory.self, TheMember.self])
            
        }
    }
}
