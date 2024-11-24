//
//  booklistview.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct BookListView: View {
    @StateObject private var viewModel = BookViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                VStack(alignment: .leading) {
                    Text(book.title).font(.headline)
                    Text(book.author).font(.subheadline)
                    Text("Year: \(book.year)").font(.caption)
                }
            }
            .navigationTitle("Books")
            .toolbar {
                Button(action: {
                    viewModel.addBook(title: "New Book", author: "Author", year: 2024)
                }) {
                    Text("Add Book")
                }
            }
            .onAppear {
                viewModel.fetchBooks()
            }
        }
    }
}
