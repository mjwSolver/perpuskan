//
//  BookCategoryViewModel.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import Combine
//
//class BookCategoryViewModel: ObservableObject {
//    @Published var categories: [BookCategory] = []
//
//    func fetchCategories() {
//        categories = DatabaseManager.shared.fetchCategories()
//    }
//
//    func addCategory(name: String) {
//        do {
//            try DatabaseManager.shared.addCategory(name: name)
//            fetchCategories()
//        } catch {
//            print("Failed to add category: \(error)")
//        }
//    }
//
//    func updateCategory(id: Int, name: String) {
//        do {
//            try DatabaseManager.shared.updateCategory(id: id, name: name)
//            fetchCategories()
//        } catch {
//            print("Failed to update category: \(error)")
//        }
//    }
//
//    func deleteCategory(id: Int) {
//        do {
//            try DatabaseManager.shared.deleteCategory(id: id)
//            fetchCategories()
//        } catch {
//            print("Failed to delete category: \(error)")
//        }
//    }
//    
//    func addCategoryToBook(bookId: Int64, categoryId: Int64) {
//        do {
//            try DatabaseManager.shared.addCategoryToBook(bookId: Int(bookId), categoryId: Int(categoryId))
//        } catch {
//            print("Failed to add category to book of \(bookId) with error: \(error)")
//        }
//    }
//    
//}

import SwiftUI
import SwiftData

@MainActor
class CategoryViewModel: ObservableObject {
    @Published var categories: [BookCategory] = []
    @Published var errorMessage: String?

    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchCategories()
    }

    func fetchCategories() {
        do {
            let allCategories = try context.fetch(FetchDescriptor<BookCategory>())
            categories = allCategories
        } catch {
            errorMessage = "Failed to fetch categories: \(error.localizedDescription)"
        }
    }

    func addCategory(name: String) {
        let newCategory = BookCategory(name: name)
        do {
            try context.insert(newCategory)
            try context.save()
            fetchCategories()
        } catch {
            errorMessage = "Failed to add category: \(error.localizedDescription)"
        }
    }

    func updateCategory(_ category: BookCategory, withName newName: String) {
        category.name = newName
        do {
            try context.save()
            fetchCategories()
        } catch {
            errorMessage = "Failed to update category: \(error.localizedDescription)"
        }
    }

    func deleteCategory(_ category: BookCategory) {
        do {
            try context.delete(category)
            try context.save()
            fetchCategories()
        } catch {
            errorMessage = "Failed to delete category: \(error.localizedDescription)"
        }
    }
}
