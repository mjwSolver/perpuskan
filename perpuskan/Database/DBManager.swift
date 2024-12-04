//
//  DBManager.swift
//  perpuskan
//
//  Created by Marcell JW on 04/12/24.
//

import SwiftData

@MainActor
class DataManager {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Create
    func create<T: PersistentModel>(_ entity: T) {
        context.insert(entity)
        saveContext()
    }

    // MARK: - Read
    func fetchAll<T: PersistentModel>(_ type: T.Type) -> [T] {
        let fetchDescriptor = FetchDescriptor<T>()
        do {
            return try context.fetch(fetchDescriptor)
        } catch {
            print("Error fetching \(type): \(error)")
            return []
        }
    }

    // MARK: - Update
    func update<T: PersistentModel>(_ entity: T, with updates: () -> Void) {
        updates()
        saveContext()
    }

    // MARK: - Delete
    func delete<T: PersistentModel>(_ entity: T) {
        context.delete(entity)
        saveContext()
    }

    // Save changes
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
