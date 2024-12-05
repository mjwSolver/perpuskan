//
//  Book.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//
//struct Book: Identifiable {
//    let id: Int64
//    let title: String
//    let author: String
//    let year: Int
//    var memberId: Int64?
//    var categories: [BookCategory] = [] // Tambahkan properti ini
//}

import Foundation
import SwiftData

@Model
class Book {
    @Attribute(.unique) var id: UUID
    var title: String
    var author: String
    var year: Int
    var member: TheMember? // Optional relationship for borrowing
    var categories: [BookCategory] = [] // Many-to-many relationship

    init(title: String, author: String, year: Int, member: TheMember? = nil, categories: [BookCategory]) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.year = year
        self.member = member
        self.categories = categories
    }
}

extension Book {
    static var mockBooks: [Book] {
        let member1 = TheMember(name: "John Doe", email: "john.doe@example.com", phone: "123-456-7890")
        let member2 = TheMember(name: "Jane Smith", email: "jane.smith@example.com", phone: "098-765-4321")
        
        let category1 = BookCategory(name: "Fiction")
        let category2 = BookCategory(name: "Non-Fiction")
        let category3 = BookCategory(name: "Technology")

        return [
            Book(title: "Swift Programming", author: "Apple Inc.", year: 2022, member: member1, categories: [category2, category3]),
            Book(title: "A Tale of Two Cities", author: "Charles Dickens", year: 1859, member: nil, categories: [category1]),
            Book(title: "Clean Code", author: "Robert C. Martin", year: 2008, member: member2, categories: [category3])
        ]
    }
}

