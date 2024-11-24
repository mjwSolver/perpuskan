//
//  AddBookView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct AddBookView: View {
    @State private var selectedCategories: [BookCategory.Category] = []

    var body: some View {
        Form {
            Section(header: Text("Select Categories")) {
                ForEach(BookCategory.Category.allCases, id: \.self) { category in
                    Toggle(category.rawValue, isOn: Binding(
                        get: { selectedCategories.contains(category) },
                        set: { isSelected in
                            if isSelected {
                                selectedCategories.append(category)
                            } else {
                                selectedCategories.removeAll { $0 == category }
                            }
                        }
                    ))
                }
            }

            Button("Save") {
                print("Selected Categories: \(selectedCategories.map { $0.rawValue })")
            }
        }
        .navigationTitle("Add Book")
    }
}

