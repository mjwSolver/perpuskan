//
//  booklistview.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct BookListView: View {
    var category: BookCategory? // Optional, to filter books by category
    @StateObject private var viewModel = BookViewModel()
    @State private var showAddBookView = false
    @State private var showEditBookView = false
    @State private var selectedBook: Book?

    var body: some View {
        NavigationView {
            List {
                bookListView()
            }
            .onAppear {
                loadBooks()
            }
            .navigationTitle(category?.name ?? "All Books")
            .toolbar {
                toolbarContent()
            }
            .sheet(isPresented: $showAddBookView) {
                AddBookView(viewModel: viewModel)
            }
            .sheet(isPresented: $showEditBookView, onDismiss: {
                selectedBook = nil
            }) {
                if let selectedBook = selectedBook {
                    EditBookView(viewModel: viewModel, book: selectedBook)
                }
            }
        }
    }

    private func bookListView() -> some View {
        ForEach(viewModel.books) { book in
            HStack {
                bookDetailsView(book: book)
                Spacer()
                actionButtons(for: book)
            }
        }
    }

    private func bookDetailsView(book: Book) -> some View {
        VStack(alignment: .leading) {
            Text(book.title).font(.headline)
            Text("Author: \(book.author)")
            Text("Year: \(book.year)")
        }
    }

    private func actionButtons(for book: Book) -> some View {
        HStack {
            // Edit Button
            Button(action: {
                selectedBook = book
                showEditBookView = true
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.trailing, 8)

            // Delete Button
            Button(action: {
                viewModel.deleteBook(bookId: book.id)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }

    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                showAddBookView = true
            }) {
                Label("Add Book", systemImage: "plus")
            }
        }
    }

    private func loadBooks() {
        if let category = category {
            viewModel.fetchBooksByCategory(categoryId: category.id)
        } else {
            viewModel.fetchAllBooks()
        }
    }

}

#Preview {
    BookListView()
}
