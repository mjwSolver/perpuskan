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
    
    func fetchBooks(forCategory categoryId: Int64) {
        books = DatabaseManager.shared.fetchBooksForCategory(categoryId: categoryId)
    }

    func addBook(title: String?, author: String?, year: Int?) {
         guard validateInput(title: title, author: author, year: year) else {
             print("Invalid input")
             return
         }

         // Lanjutkan dengan logika tambah buku
         print("Book added successfully!")
     }
    
    func addCategoryToBook(bookId: Int64, categoryId: Int64) {
        do {
            try DatabaseManager.shared.addBookToCategory(bookId: bookId, categoryId: categoryId)
        } catch {
            print("Failed to add category to book: \(error)")
        }
    }

    func fetchCategoriesForBook(bookId: Int64) -> [BookCategory] {
        return DatabaseManager.shared.fetchCategoriesForBook(bookId: bookId)
    }
    
    

    
}


