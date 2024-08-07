//
//  SearchRepoRowView.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import SwiftUI

struct SearchRepoRowView : View {

    let repository: Repository

    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {

            HStack {
                Image(systemName: "doc.text")
                Text(repository.full_name ?? repository.name)
                    .bold()
            }
            
            repository.description
                .map(Text.init)?
                .lineLimit(nil)

            HStack {
                Image(systemName: "star")
                Text("\(repository.stargazers_count ?? 0)")
            }
        }
    }
}

struct SearchRepoRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepoRowView(repository: .fake())
            .frame(width: 300, height: 100, alignment: .center)
            .background(Color.gray.opacity(0.2))
    }
}
