//
//  PersistenceController.swift
//  perpuskan
//
//  Created by Marcell JW on 04/12/24.
//

import SwiftData

class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    private init() {
        do {
            container = try ModelContainer(for: Book.self, BookCategory.self, Member.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}

import SwiftUI
import SwiftData

@MainActor
func populateMockData(context: ModelContext) {
    // Clear existing data
    context.deleteAllEntities(ofType: Book.self)
    context.deleteAllEntities(ofType: BookCategory.self)
    context.deleteAllEntities(ofType: Member.self)

    // Create mock categories
    let category1 = BookCategory(name: "Fiction")
    let category2 = BookCategory(name: "Science")
    let category3 = BookCategory(name: "History")

    // Create mock members
    let member1 = Member(name: "Alice Smith", email: "alice@example.com", phone: "123-456-7890")
    let member2 = Member(name: "Bob Johnson", email: "bob@example.com", phone: "987-654-3210")

    // Create mock books
    let book1 = Book(title: "Swift Programming", author: "Apple Inc.", year: 2023, member: member1)
    let book2 = Book(title: "AI for Everyone", author: "Andrew Ng", year: 2021)
    let book3 = Book(title: "History of the World", author: "Jared Diamond", year: 1997, member: member2)

    // Add categories to books
    book1.categories.append(category1)
    book2.categories.append(category2)
    book3.categories.append(category3)

    // Save everything
    context.insert(category1)
    context.insert(category2)
    context.insert(category3)

    context.insert(member1)
    context.insert(member2)

    context.insert(book1)
    context.insert(book2)
    context.insert(book3)

    do {
        try context.save()
        print("Mock data added successfully!")
    } catch {
        print("Failed to save mock data: \(error)")
    }
}

extension ModelContext {
    func deleteAllEntities<T: PersistentModel>(ofType type: T.Type) {
        let fetchDescriptor = FetchDescriptor<T>()
        let objects = try? fetch(fetchDescriptor)
        objects?.forEach { delete($0) }
    }
}
