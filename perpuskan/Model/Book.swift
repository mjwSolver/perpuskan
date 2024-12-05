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

    init(title: String, author: String, year: Int, member: TheMember? = nil) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.year = year
        self.member = member
    }
}
