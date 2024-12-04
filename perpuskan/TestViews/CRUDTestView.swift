//
//  CRUDTestView.swift
//  perpuskan
//
//  Created by Marcell JW on 04/12/24.
//

import SwiftUI

struct CRUDTestView: View {
    @Environment(\.modelContext) private var context
    private var dataManager: DataManager {
        DataManager(context: context)
    }

    var body: some View {
        VStack(spacing: 16) {
            Button("Create Mock Data") {
                let book = Book(title: "Test Book", author: "Test Author", year: 2024)
                dataManager.create(book)
            }
            
            Button("Fetch All Books") {
                let books = dataManager.fetchAll(Book.self)
                print(books)
            }
            
            Button("Update First Book") {
                if let firstBook = dataManager.fetchAll(Book.self).first {
                    dataManager.update(firstBook) {
                        firstBook.title = "Updated Test Book"
                    }
                }
            }
            
            Button("Delete First Book") {
                if let firstBook = dataManager.fetchAll(Book.self).first {
                    dataManager.delete(firstBook)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CRUDTestView()
}
