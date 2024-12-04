//
//  databasemanager.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SQLite
//import SQLite3
//typealias SQLExpression = SQLite.Expression
//import Foundation
//
//class DatabaseManager {
//    static let shared = DatabaseManager()
//    private var db: Connection?
//    
//    var dbTry: OpaquePointer?
//
//    
//    let dataPath: String = "MyDB"
//    
//    // Tables
//    private let booksTable = Table("Books")
//    private let membersTable = Table("Members")
//    private let categoriesTable = Table("Categories")
//    
//    // Pivot
//    private let bookCategoriesTable = Table("BookCategories")
//    private let bookIdColumn = Expression<Int>(value: 0) // "book_id"
//    private let categoryIdColumn = Expression<Int>(value: 0) // "category_id"
//    
//    // Columns for Books
//    private var bookId = Expression<Int>(value: 0)
//    private let title = Expression<String>(value: "title")
//    private let author = Expression<String>(value: "author")
//    private let year = Expression<Int>(value: 0) // "year"
//    private let memberId = Expression<Int>(value: 0) // Nullable for unloaned books
//    
//    // Columns for Members
//    private let memberIdColumn = Expression<Int>(value: 0) // "id"
//    private let memberName = Expression<String>(value: "name")
//    private let memberEmail = Expression<String>(value: "email")
//    private let memberPhone = Expression<String>(value: "phone")
//    
//    // Columns for Categories
//    private let categoryId = Expression<Int>(value: 0) // "id"
//    private let categoryName = Expression<String>(value: "name")
//    
//    
//    init() {
////        createDb()
//        dbTry = openDatabase()
//        createTables()
//    }
//    
//    func openDatabase() -> OpaquePointer? {
//        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dataPath)
//        
//        var db: OpaquePointer? = nil
//        if sqlite3_open(filePath.path, &db) != SQLITE_OK{
//            debugPrint("Cannot open DB.")
//            return nil
//        }
//        else{
//            print("DB successfully created.")
//            return db
//        }
//    }
//        
//    private func createTables() {
//        do {
//            // Create Members Table
//            try db?.run(membersTable.create(ifNotExists: true) { t in
//                t.column(memberIdColumn, primaryKey: .autoincrement)
//                t.column(memberName)
//                t.column(memberEmail, unique: true)
//                t.column(memberPhone)
//            })
//            
//            // Create Books Table (Updated to include member_id)
//            try db?.run(booksTable.create(ifNotExists: true) { t in
//                t.column(bookId, primaryKey: .autoincrement)
//                t.column(title)
//                t.column(author)
//                t.column(year)
//                t.column(memberId) // Correct type: Int64?
//            })
//            
//            // Create Categories Table
//            try db?.run(categoriesTable.create(ifNotExists: true) { t in
//                t.column(categoryId, primaryKey: .autoincrement)
//                t.column(categoryName)
//            })
//            
//            // Tabel BookCategories (Pivot)
//            try db?.run(bookCategoriesTable.create(ifNotExists: true) { t in
//                t.column(bookIdColumn)
//                t.column(categoryIdColumn)
//                t.foreignKey(bookIdColumn, references: booksTable, bookId, delete: .cascade)
//                t.foreignKey(categoryIdColumn, references: categoriesTable, categoryId, delete: .cascade)
//                t.primaryKey(bookIdColumn, categoryIdColumn) // Composite primary key
//            })
//            
//        } catch {
//            print("Failed to create tables: \(error)")
//        }
//    }
//    
//    // CRUD for Relationship Between Book and Category
//    func addBookToCategory(bookId: Int64, categoryId: Int64) throws {
//        do {
//            try db?.run(bookCategoriesTable.insert(bookIdColumn <- Int(bookId), categoryIdColumn <- Int(categoryId)))
//        } catch {
//            throw error
//        }
//    }
//    
//    func removeBookFromCategory(bookId: Int64, categoryId: Int64) throws {
//        let relation = bookCategoriesTable.filter(bookIdColumn == Int(bookId) && categoryIdColumn == Int(categoryId))
//        do {
//            try db?.run(relation.delete())
//        } catch {
//            throw error
//        }
//    }
//    
//    func fetchCategoriesForBook(bookId: Int64) -> [BookCategory] {
//        var categories = [BookCategory]()
//        do {
//            if let rows = try db?.prepare(bookCategoriesTable.filter(bookIdColumn == Int(bookId)).join(categoriesTable, on: categoryIdColumn == categoryId)) {
//                for row in rows {
//                    categories.append(BookCategory(id: Int64(row[categoryId]), name: row[categoryName]))
//                }
//            }
//        } catch {
//            print("Failed to fetch categories for book: \(error)")
//        }
//        return categories
//    }
//    
//    func fetchBooksForCategory(categoryId: Int64) -> [Book] {
//        var books = [Book]()
//        do {
//            if let rows = try db?.prepare(bookCategoriesTable.filter(categoryIdColumn == Int(categoryId)).join(booksTable, on: bookIdColumn == bookId)) {
//                for row in rows {
//                    books.append(Book(
//                        id: Int64(row[bookId]),
//                        title: row[title],
//                        author: row[author],
//                        year: row[year],
//                        memberId: Int64(row[memberId])
//                    ))
//                }
//            }
//        } catch {
//            print("Failed to fetch books for category: \(error)")
//        }
//        return books
//    }
//    
//    
//    func fetchAllBooks() -> [Book] {
//        var books = [Book]()
//        do {
//            if let rows = try db?.prepare(booksTable) {
//                for row in rows {
//                    books.append(Book(
//                        id: Int64(row[bookId]),
//                        title: row[title],
//                        author: row[author],
//                        year: row[year],
//                        memberId: Int64(row[memberId]) // Nullable for books that are not loaned
//                    ))
//                }
//            }
//        } catch {
//            print("Failed to fetch books: \(error)")
//            
////            /Users/marcelljw/Xcode Projects/perpuskan/perpuskan/perpuskan/Database/databasemanager.swift
//        }
//        return books
//    }
//    
//    // CRUD For Books
//    func addBook(title: String, author: String, year: Int, memberId: Int? = nil, categoryIds: [Int]) throws {
//        
//        do {
//            // Step 1: Insert the book into the database
//            
//            let insert = booksTable.insert(
//                self.title <- title,
//                self.author <- author,
//                self.year <- year,
//                self.memberId <- memberId ?? -1 // Handle nil memberId
//            )
//            
//            
//            guard let bookId = try db?.run(insert) else {
//                throw NSError(domain: "DatabaseError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to insert book."])
//            }
//            
//            print("Book added successfully with ID \(bookId)")
//            
//            // Step 2: Add categories to the book
//            for categoryId in categoryIds {
//                try addCategoryToBook(bookId: Int(bookId), categoryId: categoryId)
//            }
//            
//        } catch {
//            print("Failed to add book: \(error)")
//            throw error
//        }
//        
//    }
//    
//    func addCategoryToBook(bookId: Int, categoryId: Int) throws {
//        do {
//            let insertCategory = bookCategoriesTable.insert(
//                bookIdColumn <- bookId,
//                categoryIdColumn <- categoryId
//            )
//            try db?.run(insertCategory)
//            print("Added category \(categoryId) for book \(bookId)")
//        } catch {
//            print("Failed to add category \(categoryId) to book \(bookId): \(error)")
//            throw error
//        }
//    }
//    
//    func editBook(bookId: Int64, title: String?, author: String?, year: Int?, memberId: Int64? = nil) throws {
//        do {
//            let book = booksTable.filter(self.bookId == Int(bookId))
//            var updates = [Setter]()
//            
//            if let title = title {
//                updates.append(self.title <- title)
//            }
//            if let author = author {
//                updates.append(self.author <- author)
//            }
//            if let year = year {
//                updates.append(self.year <- year)
//            }
//            if let memberId = memberId {
//                updates.append(self.memberId <- Int(memberId))
//            }
//            
//            guard !updates.isEmpty else {
//                print("No updates provided for book with ID \(bookId)")
//                return
//            }
//            
//            try db?.run(book.update(updates))
//            print("Book with ID \(bookId) successfully updated.")
//        } catch {
//            print("Failed to update book with ID \(bookId): \(error)")
//            throw error
//        }
//    }
//    
//    
//    func deleteBook(bookId: Int64) throws {
//        do {
//            // Delete all associated categories for the book
//            let bookCategories = bookCategoriesTable.filter(bookIdColumn == Int(bookId))
//            try db?.run(bookCategories.delete())
//            
//            // Delete the book from the Books table
//            let book = booksTable.filter(self.bookId == Int(bookId))
//            try db?.run(book.delete())
//            
//            print("Book with ID \(bookId) and its associations successfully deleted.")
//        } catch {
//            print("Failed to delete book with ID \(bookId): \(error)")
//            throw error
//        }
//    }
//    
//    
//    
//    // CRUD Operations for Members
//    func addMember(name: String, email: String, phone: String) throws {
//        do {
//            try db?.run(membersTable.insert(
//                memberName <- name,
//                memberEmail <- email,
//                memberPhone <- phone
//            ))
//        } catch {
//            throw error
//        }
//    }
//    
//    func fetchMembers() -> [Member] {
//        var members = [Member]()
//        do {
//            if let rows = try db?.prepare(membersTable) {
//                for row in rows {
//                    members.append(Member(
//                        id: Int64(row[memberIdColumn]),
//                        name: row[memberName],
//                        email: row[memberEmail],
//                        phone: row[memberPhone]
//                    ))
//                }
//            }
//        } catch {
//            print("Failed to fetch members: \(error)")
//        }
//        return members
//    }
//    
//    func updateMember(id: Int64, name: String, email: String, phone: String) throws {
//        let memberToUpdate = membersTable.filter(memberIdColumn == Int(id))
//        do {
//            try db?.run(memberToUpdate.update(
//                memberName <- name,
//                memberEmail <- email,
//                memberPhone <- phone
//            ))
//        } catch {
//            throw error
//        }
//    }
//    
//    func deleteMember(id: Int) throws {
//        let memberToDelete = membersTable.filter(memberIdColumn == id)
//        do {
//            try db?.run(memberToDelete.delete())
//        } catch {
//            throw error
//        }
//    }
//    
//    // TODO: memberId is treated as Int, it should be Int64
//    func fetchBooksLoanedByMember(memberIdHere: Int64) -> [Book] {
//        var books = [Book]()
//        do {
//            // Query untuk mendapatkan buku yang dipinjam oleh anggota tertentu
//            if let rows = try db?.prepare(booksTable.filter(self.memberId == memberId)) {
//                for row in rows {
//                    books.append(Book(
//                        id: Int64(row[bookId]),
//                        title: row[title],
//                        author: row[author],
//                        year: row[year],
//                        memberId: Int64(row[memberId])
//                    ))
//                }
//            }
//        } catch {
//            print("Failed to fetch books loaned by member: \(error)")
//        }
//        return books
//    }
//    
//    // CRUD Operations for Categories
//    func addCategory(name: String) throws {
//        do {
//            try db?.run(categoriesTable.insert(categoryName <- name))
//        } catch {
//            throw error
//        }
//    }
//    
//    func fetchCategories() -> [BookCategory] {
//        var categories = [BookCategory]()
//        do {
//            if let rows = try db?.prepare(categoriesTable) {
//                for row in rows {
//                    categories.append(BookCategory(id: Int64(row[categoryId]), name: row[categoryName]))
//                }
//            }
//        } catch {
//            print("Failed to fetch categories: \(error)")
//        }
//        return categories
//    }
//    
//    func updateCategory(id: Int, name: String) throws {
//        let categoryToUpdate = categoriesTable.filter(categoryId == id)
//        do {
//            try db?.run(categoryToUpdate.update(categoryName <- name))
//        } catch {
//            throw error
//        }
//    }
//    
//    func deleteCategory(id: Int) throws {
//        let categoryToDelete = categoriesTable.filter(categoryId == id)
//        do {
//            try db?.run(categoryToDelete.delete())
//        } catch {
//            throw error
//        }
//    }
//    
//}
