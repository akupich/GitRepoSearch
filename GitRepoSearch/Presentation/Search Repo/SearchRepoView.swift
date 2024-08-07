//
//  SearchRepoView.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import SwiftUI

struct SearchRepoView: View {
    @ObservedObject var viewModel: SearchRepoViewModel
    
    init(viewModel: SearchRepoViewModel) {
        self.viewModel = viewModel
        
        // Only way to make List' background .clear in swiftui
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(
                    placeholderText: "Search...",
                    text: $viewModel.searchText
                )
                
                if viewModel.state.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                } else {
                    SearchResultsView(
                        results: viewModel.repositories,
                        onScrolledAtBottom: viewModel.fetchNextPageIfPossible
                    )
                }
            }
            .navigationTitle("🔍 Search Repository")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

private struct SearchResultsView: View {
    let results: [Repository]
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        List {
            ForEach(results) { item in
                Button(action: {
                    SearchRepoRouter.destinationForTappedRepo(repo: item)
                }, label: {
                    SearchRepoRowView(repository: item)
                        .onAppear {
                            if self.results.last == item {
                                self.onScrolledAtBottom()
                            }
                        }
                        .accessibilityIdentifier("searchCell")
                })
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct SearchRepoView_Previews: PreviewProvider {
    static var previews: some View {
        var state = SearchRepoViewModel.State()
        state.repos.items += [Repository.fake()]
        
        return SearchRepoView(viewModel: SearchRepoViewModel(state: state))
    }
}
