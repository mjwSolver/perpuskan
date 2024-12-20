//
//  ContentView.swift
//  perpuskan
//
//  Created by Marcell JW on 24/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                
                NavigationLink(destination: BookListView()) {
                    Text("View Books")
                }

                NavigationLink(destination: MemberListView()) {
                    Text("View Members")
                }

                NavigationLink(destination: BookCategoryListView()) {
                    Text("Manage Book Categories")
                }
                
            }
            .navigationTitle("Library App")
        }
    }
}


#Preview {
    ContentView()
}
