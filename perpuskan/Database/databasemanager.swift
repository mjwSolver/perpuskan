//
//  databasemanager.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SQLite
//import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()
    private let db: Connection?

    // Tables
    private let booksTable = Table("Books")
    private let membersTable = Table("Members")
    private let categoriesTable = Table("Categories")
    
    // Pivot
    private let bookCategoriesTable = Table("BookCategories")
    private let bookIdColumn = Expression<Int64>("book_id")
    private let categoryIdColumn = Expression<Int64>("category_id")

    // Columns for Books
    private let bookId = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let author = Expression<String>("author")
    private let year = Expression<Int>("year")
    private let memberId = Expression<Int64?>("member_id") // Nullable for unloaned books

    // Columns for Members
    private let memberIdColumn = Expression<Int64>("id")
    private let memberName = Expression<String>("name")
    private let memberEmail = Expression<String>("email")
    private let memberPhone = Expression<String>("phone")

    // Columns for Categories
    private let categoryId = Expression<Int64>("id")
    private let categoryName = Expression<String>("name")

    
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
                t.column(memberId) // Correct type: Int64?
            })

            // Create Categories Table
            try db?.run(categoriesTable.create(ifNotExists: true) { t in
                t.column(categoryId, primaryKey: .autoincrement)
                t.column(categoryName)
            })
            
            // Tabel BookCategories (Pivot)
            try db?.run(bookCategoriesTable.create(ifNotExists: true) { t in
                t.column(bookIdColumn)
                t.column(categoryIdColumn)
                t.foreignKey(bookIdColumn, references: booksTable, bookId, delete: .cascade)
                t.foreignKey(categoryIdColumn, references: categoriesTable, categoryId, delete: .cascade)
                t.primaryKey(bookIdColumn, categoryIdColumn) // Composite primary key
            })
            
        } catch {
            print("Failed to create tables: \(error)")
        }
    }

    // CRUD for Relationship Between Book and Category
    func addBookToCategory(bookId: Int64, categoryId: Int64) throws {
        do {
            try db?.run(bookCategoriesTable.insert(bookIdColumn <- bookId, categoryIdColumn <- categoryId))
        } catch {
            throw error
        }
    }
    
    func removeBookFromCategory(bookId: Int64, categoryId: Int64) throws {
        let relation = bookCategoriesTable.filter(bookIdColumn == bookId && categoryIdColumn == categoryId)
        do {
            try db?.run(relation.delete())
        } catch {
            throw error
        }
    }
    
    func fetchCategoriesForBook(bookId: Int64) -> [BookCategory] {
        var categories = [BookCategory]()
        do {
            if let rows = try db?.prepare(bookCategoriesTable.filter(bookIdColumn == bookId).join(categoriesTable, on: categoryIdColumn == categoryId)) {
                for row in rows {
                    categories.append(BookCategory(id: row[categoryId], name: row[categoryName]))
                }
            }
        } catch {
            print("Failed to fetch categories for book: \(error)")
        }
        return categories
    }

    func fetchBooksForCategory(categoryId: Int64) -> [Book] {
        var books = [Book]()
        do {
            if let rows = try db?.prepare(bookCategoriesTable.filter(categoryIdColumn == categoryId).join(booksTable, on: bookIdColumn == bookId)) {
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
            print("Failed to fetch books for category: \(error)")
        }
        return books
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

    func updateMember(id: Int64, name: String, email: String, phone: String) throws {
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

    func deleteMember(id: Int64) throws {
        let memberToDelete = membersTable.filter(memberIdColumn == id)
        do {
            try db?.run(memberToDelete.delete())
        } catch {
            throw error
        }
    }

    // Fetch Books Loaned by a Member
    func fetchBooksLoanedByMember(memberId: Int64) -> [Book] {
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

    func updateCategory(id: Int64, name: String) throws {
        let categoryToUpdate = categoriesTable.filter(categoryId == id)
        do {
            try db?.run(categoryToUpdate.update(categoryName <- name))
        } catch {
            throw error
        }
    }

    func deleteCategory(id: Int64) throws {
        let categoryToDelete = categoriesTable.filter(categoryId == id)
        do {
            try db?.run(categoryToDelete.delete())
        } catch {
            throw error
        }
    }
}
