//
//  AddBookView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

import SwiftUI

struct AddBookView: View {
    
    @ObservedObject var viewModel: BookViewModel // Shared ViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var author: String = ""
    @State private var year: String = ""
    @State private var selectedCategoryIds: Set<Int64> = [] // To avoid duplicates

    var body: some View {
        NavigationView {
            Form {
                // Book Details Section
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                        .autocorrectionDisabled()
                    TextField("Author", text: $author)
                        .autocorrectionDisabled()
                    TextField("Year", text: $year)
                        .keyboardType(.numberPad)
                }

                // Categories Selection Section
                Section(header: Text("Select Categories")) {
                    ForEach(viewModel.categories, id: \.id) { category in
                        Toggle(category.name, isOn: Binding(
                            get: { selectedCategoryIds.contains(category.id) },
                            set: { isSelected in
                                if isSelected {
                                    selectedCategoryIds.insert(category.id)
                                } else {
                                    selectedCategoryIds.remove(category.id)
                                }
                            }
                        ))
                    }
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                // Save Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveBook()
                    }
                }
                // Cancel Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                viewModel.fetchCategories() // Fetch categories when the view appears
            }
        }
    }

    private func saveBook() {
        guard !title.isEmpty, !author.isEmpty, let yearInt = Int(year) else {
            print("All fields are required.")
            return
        }

        // Add the book using the ViewModel
        viewModel.addBook(title: title, author: author, year: yearInt, categoryIds: Array(selectedCategoryIds))
        dismiss()
    }
}


//struct AddBookView_Previews: PreviewProvider {
//    static var previews: some View {
//       AddBookView()
//    }
//}


