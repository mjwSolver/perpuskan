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
    
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            
            CRUDTestView()
                .modelContainer(for: [Book.self, BookCategory.self, Member.self]) // Register all models
            
//            ContentView()
//                .modelContainer(persistenceController.container)
//                .onAppear {
//                    Task {
//                        await MainActor.run {
//                            populateMockData(context: persistenceController.container.mainContext)
//                        }
//                    }
//                }
                
        }
    }
}
