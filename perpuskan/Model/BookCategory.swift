//
//  BookCategory.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Foundation

class BookCategory {
    enum Category: String, CaseIterable {
        case fiction = "Fiction"
        case nonFiction = "Non-Fiction"
        case science = "Science"
        case history = "History"

        var description: String {
            switch self {
            case .fiction:
                return "Books that contain fictional stories."
            case .nonFiction:
                return "Books based on real facts and information."
            case .science:
                return "Books related to scientific discoveries and concepts."
            case .history:
                return "Books about historical events and people."
            }
        }
    }
}
