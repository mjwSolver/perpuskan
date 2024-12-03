//
//  BookCategoryViewModel.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Combine

class BookCategoryViewModel: ObservableObject {
    @Published var categories: [BookCategory] = []

    func fetchCategories() {
        categories = DatabaseManager.shared.fetchCategories()
    }

    func addCategory(name: String) {
        do {
            try DatabaseManager.shared.addCategory(name: name)
            fetchCategories()
        } catch {
            print("Failed to add category: \(error)")
        }
    }

    func updateCategory(id: Int, name: String) {
        do {
            try DatabaseManager.shared.updateCategory(id: id, name: name)
            fetchCategories()
        } catch {
            print("Failed to update category: \(error)")
        }
    }

    func deleteCategory(id: Int) {
        do {
            try DatabaseManager.shared.deleteCategory(id: id)
            fetchCategories()
        } catch {
            print("Failed to delete category: \(error)")
        }
    }
}
