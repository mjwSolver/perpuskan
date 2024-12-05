//
//  BookCategoriesView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SwiftUI
//
//struct BookCategoryListView: View {
//    @StateObject private var viewModel = BookCategoryViewModel()
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.categories) { category in
//                    NavigationLink(destination: EditCategoryView(category: category)) {
//                        Text(category.name)
//                    }
//                }
//                .onDelete { indexSet in
//                    indexSet.forEach { index in
//                        let category = viewModel.categories[index]
//                        viewModel.deleteCategory(id: Int(category.id))
//                    }
//                }
//            }
//            .navigationTitle("Book Categories")
//            .toolbar {
//                NavigationLink(destination: AddCategoryView()) {
//                    Text("Add Category")
//                }
//            }
//            .onAppear {
//                viewModel.fetchCategories()
//            }
//        }
//    }
//}
//
//#Preview {
//    BookCategoryListView()
//}

import SwiftUI
import SwiftData

struct CategoryListView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: CategoryViewModel

    // Custom initializer, wait for full file to iniaitlize, then create the CategoryViewModel's dependency.
    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: CategoryViewModel(context: context))
    }

    @State private var showAddCategoryView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: EditCategoryView(category: category, viewModel: viewModel)) {
                        Text(category.name)
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.categories[$0] }.forEach(viewModel.deleteCategory)
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddCategoryView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddCategoryView) {
                AddCategoryView(viewModel: viewModel)
            }
            .alert("Error", isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }

    }
}
