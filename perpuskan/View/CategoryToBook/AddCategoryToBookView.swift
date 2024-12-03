//
//  AddCategoryToBookView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct AddCategoryToBookView: View {
    
    let book: Book
    @State private var selectedCategoryId: Int64 = 0
    @StateObject private var viewModel = BookCategoryViewModel()

    var body: some View {
        Form {
            Picker("Category", selection: $selectedCategoryId) {
                ForEach(viewModel.categories) { category in
                    Text(category.name).tag(category.id)
                }
            }

            Button("Add Category") {
                viewModel.addCategoryToBook(bookId: book.id, categoryId: selectedCategoryId)
            }
        }
        .onAppear {
            viewModel.fetchCategories()
        }
        .navigationTitle("Add Category to \(book.title)")
    }
}

#Preview {
    AddCategoryToBookView(book: Book(id: 1, title: "something", author: "bla", year: 2022))
}

