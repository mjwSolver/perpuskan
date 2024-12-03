//
//  AddBookView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct AddBookView: View {
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var year: String = ""
    @State private var selectedCategoryIds: Set<Int64> = [] // Gunakan Set untuk menghindari duplikasi
    
    @StateObject private var categoryViewModel = BookCategoryViewModel() // ViewModel untuk kategori

    var body: some View {
        Form {
            Section(header: Text("Book Details")) {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                TextField("Year", text: $year)
            }

            Section(header: Text("Select Categories")) {
                ForEach(categoryViewModel.categories, id: \.id) { category in
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

            Button("Save") {
                saveBook()
            }
        }
        .navigationTitle("Add Book")
        .onAppear {
            categoryViewModel.fetchCategories() // Fetch daftar kategori saat tampilan muncul
        }
    }

    private func saveBook() {
        guard !title.isEmpty, !author.isEmpty, let yearInt = Int(year) else {
            print("All fields are required.")
            return
        }
        // Simpan buku dengan kategori yang dipilih
        print("Saving Book: Title=\(title), Author=\(author), Year=\(yearInt), Categories=\(selectedCategoryIds)")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
