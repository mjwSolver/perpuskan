//
//  EditBookView.swift
//  perpuskan
//
//  Created by Marcell JW on 04/12/24.
//

import SwiftUI

struct EditBookView: View {
    @ObservedObject var viewModel: BookViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var author: String
    @State private var year: String
    let book: Book

    init(viewModel: BookViewModel, book: Book) {
        self.viewModel = viewModel
        self.book = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
        _year = State(initialValue: "\(book.year)")
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                TextField("Year", text: $year)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Edit Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let yearInt = Int(year) {
                            viewModel.editBook(bookId: book.id, title: title, author: author, year: yearInt)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
