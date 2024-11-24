//
//  AddCategoryView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject private var viewModel = BookCategoryViewModel()
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Category Name", text: $name)

            Button("Save") {
                viewModel.addCategory(name: name)
                name = "" // Reset field
            }
            .disabled(name.isEmpty)
        }
        .navigationTitle("Add Category")
    }
}
