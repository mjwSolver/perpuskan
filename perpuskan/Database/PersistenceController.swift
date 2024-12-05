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
            container = try ModelContainer(for: Book.self, BookCategory.self, TheMember.self)
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
    context.deleteAllEntities(ofType: TheMember.self)

    // Create mock categories
    let fiction = BookCategory(name: "Fiction")
    let science = BookCategory(name: "Science")
    let history = BookCategory(name: "History")

    // Create mock members
    let alice = TheMember(name: "Alice Smith", email: "alice@example.com", phone: "123-456-7890")
    let bob = TheMember(name: "Bob Johnson", email: "bob@example.com", phone: "987-654-3210")

    // Create mock books
    let swiftProgramming = Book(title: "Swift Programming", author: "Apple Inc.", year: 2023, member: alice, categories: [fiction])
    let aiForEveryone = Book(title: "AI for Everyone", author: "Andrew Ng", year: 2021, categories: [science])
    let historyOfTheWorld = Book(title: "History of the World", author: "Jared Diamond", year: 1997, member: bob, categories: [history])

    // Insert everything
    context.insert(fiction)
    context.insert(science)
    context.insert(history)

    context.insert(alice)
    context.insert(bob)

    context.insert(swiftProgramming)
    context.insert(aiForEveryone)
    context.insert(historyOfTheWorld)

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
