//
//  databasemanager.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    private let db: Connection?

    private let booksTable = Table("Books")
    private let categoriesTable = Table("Categories")
    private let membersTable = Table("Members")
    private let bookCategoriesTable = Table("BookCategories")

    init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        db = try? Connection("\(path)/library.sqlite3")

        createTables()
    }

    private func createTables() {
        do {
            try db?.run(booksTable.create { t in
                t.column(Expression<Int>("id"), primaryKey: true)
                t.column(Expression<String>("title"))
                t.column(Expression<String>("author"))
                t.column(Expression<Int>("year"))
                t.column(Expression<Int?>("member_id"))
            })

            try db?.run(categoriesTable.create { t in
                t.column(Expression<Int>("id"), primaryKey: true)
                t.column(Expression<String>("name"))
            })

            try db?.run(membersTable.create { t in
                t.column(Expression<Int>("id"), primaryKey: true)
                t.column(Expression<String>("name"))
                t.column(Expression<String>("email"))
                t.column(Expression<String>("phone"))
            })

            try db?.run(bookCategoriesTable.create { t in
                t.column(Expression<Int>("id"), primaryKey: true)
                t.column(Expression<Int>("book_id"))
                t.column(Expression<Int>("category_id"))
            })
        } catch {
            print("Failed to create tables: \(error)")
        }
    }
}
