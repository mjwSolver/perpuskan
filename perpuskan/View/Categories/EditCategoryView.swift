//
//  EditCategoryView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SwiftUI
//
//struct EditCategoryView: View {
//    let category: BookCategory
//    @StateObject private var viewModel = BookCategoryViewModel()
//    @State private var name: String
//
//    init(category: BookCategory) {
//        self.category = category
//        _name = State(initialValue: category.name)
//    }
//
//    var body: some View {
//        Form {
//            TextField("Category Name", text: $name)
//
//            Button("Update") {
//                viewModel.updateCategory(id: Int(category.id), name: name)
//            }
//            .disabled(name.isEmpty)
//        }
//        .navigationTitle("Edit Category")
//    }
//}

import SwiftUI

struct EditCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: CategoryViewModel

    var category: BookCategory
    @State private var categoryName: String

    init(category: BookCategory, viewModel: CategoryViewModel) {
        self.category = category
        self.viewModel = viewModel
        _categoryName = State(initialValue: category.name)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Name")) {
                    TextField("Enter name", text: $categoryName)
                }
            }
            .navigationTitle("Edit Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateCategory(category, withName: categoryName)
                        dismiss()
                    }.disabled(categoryName.isEmpty)
                }
            }
        }
    }
}

