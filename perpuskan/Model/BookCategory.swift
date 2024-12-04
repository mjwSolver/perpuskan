//
//  BookCategory.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//


//struct BookCategory: Identifiable {
//    let id: Int64
//    let name: String
//}

import Foundation
import SwiftData

@Model
class BookCategory {
    @Attribute(.unique) var id: UUID
    var name: String
    var books: [Book] = [] // Many-to-many inverse relationship

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

