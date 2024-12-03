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
    @State private var showEmailError = false

    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .onChange(of: email) { _, newValue in
                    showEmailError = !newValue.contains("@")
                }
            
            if showEmailError {
                Text("Email must contain an '@' symbol.")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            TextField("Phone", text: $phone)
                .keyboardType(.numberPad) // Use numeric keyboard
                .onChange(of: phone) { _, newValue in
                    // Filter out non-numeric characters
                    phone = newValue.filter { $0.isNumber }
                }

            Button("Save") {
                viewModel.addMember(name: name, email: email, phone: phone)
            }
        }
        .navigationTitle("Add Member")
    }
}

#Preview {
    AddMemberView()
}
