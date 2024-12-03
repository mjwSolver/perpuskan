//
//  Book.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Foundation

struct Book: Identifiable {
    let id: Int64
    let title: String
    let author: String
    let year: Int
    var memberId: Int64?
    var categories: [BookCategory] = [] // Tambahkan properti ini
}


