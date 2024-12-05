//
//  ContentView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        CategoryListView(context: modelContext)
        .onAppear {
            insertMockData(context: modelContext.container.mainContext)
        }
            
    }

    func insertMockData(context: ModelContext) {
        
        guard let existingCategories = try? context.fetch(FetchDescriptor<BookCategory>()), existingCategories.isEmpty else {
            return
        }

        let mockCategories = ["Fiction", "Non-Fiction", "Programming", "Science"]
        for categoryName in mockCategories {
            let category = BookCategory(name: categoryName)
            try? context.insert(category)
        }
        try? context.save()
    }

}


#Preview {
    ContentView()
}
