//
//  EditCategoryView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct EditCategoryView: View {
    let category: BookCategory
    @StateObject private var viewModel = BookCategoryViewModel()
    @State private var name: String

    init(category: BookCategory) {
        self.category = category
        _name = State(initialValue: category.name)
    }

    var body: some View {
        Form {
            TextField("Category Name", text: $name)

            Button("Update") {
                viewModel.updateCategory(id: category.id, name: name)
            }
            .disabled(name.isEmpty)
        }
        .navigationTitle("Edit Category")
    }
}
