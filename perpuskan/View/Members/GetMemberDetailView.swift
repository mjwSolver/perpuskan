//
//  GetMemberDetailView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SwiftUI
//
//struct MemberDetailView: View {
//    let member: Member
//    @StateObject private var viewModel = MemberViewModel()
//
//    var body: some View {
//        List(viewModel.booksLoanedByMember) { book in
//            VStack(alignment: .leading) {
//                Text(book.title).font(.headline)
//                Text("Author: \(book.author)")
//                Text("Year: \(book.year)")
//            }
//        }
//        .navigationTitle(member.name)
//        .onAppear {
//            viewModel.fetchBooksLoanedByMember(memberId: Int(member.id))
//        }
//    }
//}
