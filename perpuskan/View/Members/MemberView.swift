//
//  MemberView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

//import SwiftUI
//
//struct MemberListView: View {
//    @StateObject private var viewModel = MemberViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.members) { member in
//                NavigationLink(destination: MemberDetailView(member: member)) {
//                    VStack(alignment: .leading) {
//                        Text(member.name).font(.headline)
//                        Text(member.email).font(.subheadline)
//                    }
//                }
//            }
//            .navigationTitle("Members")
//            .toolbar {
//                NavigationLink(destination: AddMemberView()) {
//                    Text("Add Member")
//                }
//            }
//            .onAppear {
//                viewModel.fetchMembers()
//            }
//        }
//    }
//}
