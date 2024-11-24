//
//  databasemanager.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SQLite
import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()
    private let db: Connection?

    // Tables
    private let booksTable = Table("Books")
    private let membersTable = Table("Members")
    private let categoriesTable = Table("Categories")
    
    // Columns for Books
    private let bookId = Expression<Int>(value: "id")
    private let title = Expression<String>(value: "title")
    private let author = Expression<String>(value: "author")
    private let year = Expression<Int>(value: "year")
    private let memberId = Expression<Int?>(value: "member_id") // Nullable for unloaned books

    // Columns for Members
    private let memberIdColumn = Expression<Int>(value: "id")
    private let memberName = Expression<String>(value: "name")
    private let memberEmail = Expression<String>(value: "email")
    private let memberPhone = Expression<String>(value: "phone")

    // Columns for Categories
    private var categoryId = Expression<Int>(value: "id")
    private var categoryName = Expression<String>(value: "name")
    
    init() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("library.sqlite3").path
        do {
            db = try Connection(path)
            createTables()
        } catch {
            db = nil
            print("Failed to initialize database connection: \(error)")
        }
    }


    private func createTables() {
        do {
            // Create Members Table
            try db?.run(membersTable.create(ifNotExists: true) { t in
                t.column(memberIdColumn, primaryKey: .autoincrement)
                t.column(memberName)
                t.column(memberEmail, unique: true)
                t.column(memberPhone)
            })

            // Create Books Table (Updated to include member_id)
            try db?.run(booksTable.create(ifNotExists: true) { t in
                t.column(bookId, primaryKey: .autoincrement)
                t.column(title)
                t.column(author)
                t.column(year)
                t.column(memberId)
            })
            
            try db?.run(categoriesTable.create(ifNotExists: true) { t in
                t.column(categoryId, primaryKey: .autoincrement)
                t.column(categoryName)
            })
            
        } catch {
            print("Failed to create tables: \(error)")
        }
    }

    // CRUD Operations for Members
    func addMember(name: String, email: String, phone: String) throws {
        do {
            try db?.run(membersTable.insert(
                memberName <- name,
                memberEmail <- email,
                memberPhone <- phone
            ))
        } catch {
            throw error
        }
    }

    func fetchMembers() -> [Member] {
        var members = [Member]()
        do {
            if let rows = try db?.prepare(membersTable) {
                for row in rows {
                    members.append(Member(
                        id: row[memberIdColumn],
                        name: row[memberName],
                        email: row[memberEmail],
                        phone: row[memberPhone]
                    ))
                }
            }
        } catch {
            print("Failed to fetch members: \(error)")
        }
        return members
    }

    func updateMember(id: Int, name: String, email: String, phone: String) throws {
        let memberToUpdate = membersTable.filter(memberIdColumn == id)
        do {
            try db?.run(memberToUpdate.update(
                memberName <- name,
                memberEmail <- email,
                memberPhone <- phone
            ))
        } catch {
            throw error
        }
    }

    func deleteMember(id: Int) throws {
        let memberToDelete = membersTable.filter(memberIdColumn == id)
        do {
            try db?.run(memberToDelete.delete())
        } catch {
            throw error
        }
    }

    // Fetch Books Loaned by a Member
    func fetchBooksLoanedByMember(memberId: Int) -> [Book] {
        var books = [Book]()
        do {
            if let rows = try db?.prepare(booksTable.filter(self.memberId == memberId)) {
                for row in rows {
                    books.append(Book(
                        id: row[bookId],
                        title: row[title],
                        author: row[author],
                        year: row[year],
                        memberId: row[memberId]
                    ))
                }
            }
        } catch {
            print("Failed to fetch books loaned by member: \(error)")
        }
        return books
    }
    
    
    // CRUD Operations for Categories
    func addCategory(name: String) throws {
        do {
            try db?.run(categoriesTable.insert(categoryName <- name))
        } catch {
            throw error
        }
    }

    func fetchCategories() -> [BookCategory] {
        var categories = [BookCategory]()
        do {
            if let rows = try db?.prepare(categoriesTable) {
                for row in rows {
                    categories.append(BookCategory(id: row[categoryId], name: row[categoryName]))
                }
            }
        } catch {
            print("Failed to fetch categories: \(error)")
        }
        return categories
    }

    func updateCategory(id: Int, name: String) throws {
        let categoryToUpdate = categoriesTable.filter(categoryId == id)
        do {
            try db?.run(categoryToUpdate.update(categoryName <- name))
        } catch {
            throw error
        }
    }

    func deleteCategory(id: Int) throws {
        let categoryToDelete = categoriesTable.filter(categoryId == id)
        do {
            try db?.run(categoryToDelete.delete())
        } catch {
            throw error
        }
    }
}
    
    
}
