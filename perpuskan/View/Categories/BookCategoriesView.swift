//
//  BookCategoriesView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct BookCategoryListView: View {
    @StateObject private var viewModel = BookCategoryViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: EditCategoryView(category: category)) {
                        Text(category.name)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let category = viewModel.categories[index]
                        viewModel.deleteCategory(id: category.id)
                    }
                }
            }
            .navigationTitle("Book Categories")
            .toolbar {
                NavigationLink(destination: AddCategoryView()) {
                    Text("Add Category")
                }
            }
            .onAppear {
                viewModel.fetchCategories()
            }
        }
    }
}

