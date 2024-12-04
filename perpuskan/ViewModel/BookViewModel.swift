//
//  bookviewmodel.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Combine

class BookViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    @Published var categories: [BookCategory] = []

    
    // Validation
    func validateInput(title: String?, author: String?, year: Int?) -> Bool {
        guard let title = title, !title.isEmpty,
              let author = author, !author.isEmpty,
              let year = year else { return false }
        return true
    }

    // Basic Book Operations
    func fetchAllBooks() {
        books = DatabaseManager.shared.fetchAllBooks()
    }

    func addBook(title: String?, author: String?, year: Int?, categoryIds: [Int64]) {
        guard validateInput(title: title, author: author, year: year) else {
            print("Invalid input")
            return
        }

        guard let title = title, let author = author, let year = year else {
            return
        }

        do {
            let newBookId = try DatabaseManager.shared.addBook(title: title, author: author, year: year, categoryIds: categoryIds)
//            print("Book added with ID \(bookId)")
            fetchAllBooks() // Refresh the book list
        } catch {
            print("Error adding book: \(error)")
        }
    }
    
    func editBook(bookId: Int64, title: String?, author: String?, year: Int?) {
        guard validateInput(title: title, author: author, year: year) else {
            print("Invalid input")
            return
        }

        do {
            try DatabaseManager.shared.editBook(bookId: bookId, title: title, author: author, year: year)
            print("Book with ID \(bookId) updated successfully.")
            fetchAllBooks() // Refresh the book list
        } catch {
            print("Error updating book: \(error)")
        }
    }
    
    func deleteBook(bookId: Int64) {
        do {
            // Call the DatabaseManager's delete function
            try DatabaseManager.shared.deleteBook(bookId: bookId)
            
            // Update the local list of books
            books.removeAll { $0.id == bookId }
        } catch {
            print("Failed to delete book: \(error.localizedDescription)")
        }
    }
        
    // Just Category
    func fetchCategories() {
        categories = DatabaseManager.shared.fetchCategories()
    }
    
    // Book and Category
    
    func fetchBooksByCategory(categoryId: Int64) {
        books = DatabaseManager.shared.fetchBooksForCategory(categoryId: categoryId)
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


