//
//  SearchBar.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import SwiftUI

struct SearchBar: View {
    let placeholderText: String
    @Binding var text: String

    var body: some View {
        TextField(placeholderText, text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                }
            )
            .padding()
            .accessibilityIdentifier("searchTextField")
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(placeholderText: "Search here", text: Binding.constant(""))
    }
}
