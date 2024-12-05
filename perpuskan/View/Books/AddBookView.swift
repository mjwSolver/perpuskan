//
//  AddBookView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SwiftUI
//
//struct AddBookView: View {
//    
//    @ObservedObject var viewModel: BookViewModel // Shared ViewModel
//    @Environment(\.dismiss) private var dismiss
//
//    @State private var title: String = ""
//    @State private var author: String = ""
//    @State private var year: String = ""
//    @State private var selectedCategoryIds: Set<Int> = [] // To avoid duplicates
//
//    var body: some View {
//         NavigationView {
//             Form {
//                 // Book Details Section
//                 bookDetailsSection()
//
//                 // Categories Selection Section
//                 categoriesSelectionSection()
//             }
//             .navigationTitle("Add Book")
//             .toolbar {
//                 toolbarContent()
//             }
//             .onAppear {
//                 viewModel.fetchCategories() // Fetch categories when the view appears
//             }
//         }
//     }
//    
//    
//    // Book Details Section
//    @ViewBuilder
//    private func bookDetailsSection() -> some View {
//        Section(header: Text("Book Details")) {
//            TextField("Title", text: $title)
//                .autocorrectionDisabled()
//            TextField("Author", text: $author)
//                .autocorrectionDisabled()
//            TextField("Year", text: $year)
//                .keyboardType(.numberPad)
//        }
//    }
//    
//    
//    @ViewBuilder
//    private func categoriesSelectionSection() -> some View {
//        Section(header: Text("Select Categories")) {
//            ForEach(viewModel.categories, id: \.id) { category in
//                Toggle(category.name, isOn: Binding(
//                    get: { selectedCategoryIds.contains(Int(category.id)) },
//                    set: { isSelected in
//                        if isSelected {
//                            selectedCategoryIds.insert(Int(category.id))
//                        } else {
//                            selectedCategoryIds.remove(Int(category.id))
//                        }
//                    }
//                ))
//            }
//        }
//    }
//    
//    @ToolbarContentBuilder
//    private func toolbarContent() -> some ToolbarContent {
//        // Save Button
//        ToolbarItem(placement: .navigationBarTrailing) {
//            Button("Save") {
//                saveBook()
//            }
//        }
//        // Cancel Button
//        ToolbarItem(placement: .navigationBarLeading) {
//            Button("Cancel") {
//                dismiss()
//            }
//        }
//    }
//    
//    private func saveBook() {
//        guard !title.isEmpty, !author.isEmpty, let yearInt = Int(year) else {
//            print("All fields are required.")
//            return
//        }
//
//        // Add the book using the ViewModel
//        viewModel.addBook(title: title, author: author, year: yearInt, categoryIds: Array(selectedCategoryIds))
//        dismiss()
//    }
//    
//    
//}

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var year: String = ""
    @State private var selectedCategories: [BookCategory] = []
    @State private var selectedMember: TheMember?
    
    let viewModel: BookViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Book Details")) {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                TextField("Year", text: $year)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Categories")) {
                // Category selection logic (to be implemented)
            }
            
            Section(header: Text("Member")) {
                // Member selection logic (to be implemented)
            }
        }
        .navigationTitle("Add Book")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    guard let yearInt = Int(year) else { return }
                    viewModel.addBook(
                        title: title,
                        author: author,
                        year: yearInt,
                        categories: selectedCategories,
                        member: selectedMember
                    )
                    dismiss()
                }
            }
        }
    }
}
