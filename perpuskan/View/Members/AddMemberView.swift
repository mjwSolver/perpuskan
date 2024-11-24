//
//  AddMemberView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct AddMemberView: View {
    @StateObject private var viewModel = MemberViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""

    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            TextField("Phone", text: $phone)

            Button("Save") {
                viewModel.addMember(name: name, email: email, phone: phone)
            }
        }
        .navigationTitle("Add Member")
    }
}
