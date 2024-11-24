//
//  bookviewmodel.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Combine

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []

    func validateInput(title: String?, author: String?, year: Int?) -> Bool {
        guard let title = title, !title.isEmpty,
              let author = author, !author.isEmpty,
              let year = year else { return false }
        return true
    }
    
    func fetchBooks() {
        // Implementasikan query untuk mengambil data buku
    }

    func addBook(title: String?, author: String?, year: Int?) {
         guard validateInput(title: title, author: author, year: year) else {
             print("Invalid input")
             return
         }

         // Lanjutkan dengan logika tambah buku
         print("Book added successfully!")
     }
}


