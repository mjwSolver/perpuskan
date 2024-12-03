//
//  booklistview.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct BookListView: View {
    var category: BookCategory? // Opsional jika filter berdasarkan kategori
    @StateObject private var viewModel = BookViewModel()

    var body: some View {
        List(viewModel.books) { book in
            VStack(alignment: .leading) {
                Text(book.title).font(.headline)
                Text("Author: \(book.author)")
                Text("Year: \(book.year)")
            }
        }
        .onAppear {
            if let category = category {
                viewModel.fetchBooksByCategory(forCategory: category.id)
            } else {
                viewModel.fetchAllBooks()
            }
        }
        .navigationTitle(category?.name ?? "All Books")
    }
}

