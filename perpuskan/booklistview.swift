//
//  booklistview.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct BookListView: View {
    @StateObject var viewModel = BookViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                VStack(alignment: .leading) {
                    Text(book.title).font(.headline)
                    Text(book.author).font(.subheadline)
                }
            }
            .navigationTitle("Books")
            .onAppear {
                viewModel.fetchBooks()
            }
        }
    }
}
