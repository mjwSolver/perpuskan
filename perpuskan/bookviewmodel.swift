//
//  bookviewmodel.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Combine

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []

    func fetchBooks() {
        // Implementasikan query untuk mengambil data buku
    }

    func addBook(title: String, author: String, year: Int, categories: [Int]) {
        // Implementasikan logika untuk menambah buku baru
    }
}


