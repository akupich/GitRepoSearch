//
//  SearchRepoConfigurator.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation

final class SearchRepoConfigurator {
    
    public static func configureSearchRepoView (
        with viewModel: SearchRepoViewModel = SearchRepoViewModel()
    ) -> SearchRepoView {
        
        if ProcessInfo.processInfo.arguments.contains("testMode") {
            let mockedRepos = Repositories(total_count: 1, incomplete_results: false, items: [Repository.fake()])
            let mockedViewModel = SearchRepoViewModel(repositoryService: RepositoryServiceMock(data: mockedRepos))
            let searchRepoView = SearchRepoView(viewModel: mockedViewModel)
            return searchRepoView
        }
        
        let searchRepoView = SearchRepoView(viewModel: viewModel)
        return searchRepoView
    }
}
