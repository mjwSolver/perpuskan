//
//  Member.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//struct Member: Identifiable {
//    let id: Int64
//    let name: String
//    let email: String
//    let phone: String
//}

import SwiftData
import Foundation

@Model
class Member {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var phone: String
    var borrowedBooks: [Book] = [] // One-to-many relationship

    init(name: String, email: String, phone: String) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.phone = phone
    }
}
