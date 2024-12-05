//
//  AddCategoryView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SwiftUI
//
//struct AddCategoryView: View {
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    @StateObject private var viewModel = BookCategoryViewModel()
//    @State private var name = ""
//
//    var body: some View {
//        Form {
//            TextField("Category Name", text: $name)
//
//            Button("Save") {
//                viewModel.addCategory(name: name)
//                name = "" // Reset field
//                dismiss()
//            }
//            .disabled(name.isEmpty)
//        }
//        .navigationTitle("Add Category")
//    }
//}

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: CategoryViewModel

    @State private var categoryName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Name")) {
                    TextField("Enter name", text: $categoryName)
                }
            }
            .navigationTitle("Add Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addCategory(name: categoryName)
                        dismiss()
                    }.disabled(categoryName.isEmpty)
                }
            }
        }
    }
}

