//
//  MemberViewModel.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import Combine

class MemberViewModel: ObservableObject {
    @Published var members: [Member] = []
    @Published var booksLoanedByMember: [Book] = []

    func fetchMembers() {
        members = DatabaseManager.shared.fetchMembers()
    }

    func addMember(name: String, email: String, phone: String) {
        do {
            try DatabaseManager.shared.addMember(name: name, email: email, phone: phone)
            fetchMembers()
        } catch {
            print("Failed to add member: \(error)")
        }
    }

    func updateMember(id: Int, name: String, email: String, phone: String) {
        do {
            try DatabaseManager.shared.updateMember(id: id, name: name, email: email, phone: phone)
            fetchMembers()
        } catch {
            print("Failed to update member: \(error)")
        }
    }

    func deleteMember(id: Int) {
        do {
            try DatabaseManager.shared.deleteMember(id: id)
            fetchMembers()
        } catch {
            print("Failed to delete member: \(error)")
        }
    }

    func fetchBooksLoanedByMember(memberId: Int) {
        booksLoanedByMember = DatabaseManager.shared.fetchBooksLoanedByMember(memberId: memberId)
    }
}
