//
//  Book.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Foundation

struct Book: Identifiable {
    let id: Int
    let title: String
    let author: String
    let year: Int
    var categories: [BookCategory.Category]
}

