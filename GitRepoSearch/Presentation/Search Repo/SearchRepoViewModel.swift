//
//  SearchRepoViewModel.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import Foundation
import Combine
import UIKit

// TODO: wrp
class SearchRepoViewModel: ObservableObject {
    struct State {
        var repos = Repositories.empty
        var page: Int = 1
        var totalPages: Int?
        var isLoading = false
    }
    
    private var repositoryService: RepositoryServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private let inputTimeout = DispatchQueue.SchedulerTimeType.Stride.seconds(0.3)
    
    @Published private(set) var state: State
    @Published var searchText = String()
    
    var repositories: [Repository] {
        return state.repos.items
    }
    
    // MARK: - Initialization
    init(state: State = .init(),
         repositoryService: RepositoryServiceProtocol = RepositoryService()) {
        
        self.state = state
        self.repositoryService = repositoryService
    }
    
    // MARK: - Public
    public func onAppear() {
        let search = $searchText
            .dropFirst()
            .debounce(for: inputTimeout, scheduler: DispatchQueue.main)
            .removeDuplicates()
            
        search
            .filter { !$0.isEmpty }
            .map { _ in true }
            .assign(to: \.state.isLoading, on: self)
            .store(in: &cancellables)
        
        search
            .map {
                if $0.count < 1 {
                    self.state = State()
                    return nil
                }
                
                return $0
            }
            .compactMap{ $0 }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.state = State()
            })
            .sink(receiveValue: { [weak self] searchQuery in
                self?.searchRepositories(for: searchQuery)
            })
            .store(in: &cancellables)
    }
    
    public func fetchNextPageIfPossible() {
        guard let total = state.totalPages,
              total > state.page
        else {
            return
        }
        
        state.page += 1
        searchRepositories(for: searchText)
    }
    
    // MARK: - Private handlers
    private func searchRepositories(for query: String) {
        repositoryService.searchRepositories(for: query, page: state.page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: onComplete,
                  receiveValue: onReceive)
            .store(in: &cancellables)
    }
    
    private func onComplete(_ completion: Subscribers.Completion<NetworkError>) {
        defer { state.isLoading = false }
        
        switch completion {
        case .failure(let error):
            // TODO: Handle error types properly
            switch error {
            case .decodingFailed, .sessionFailed, .other:
                print("Searching failed. Failure reason: \(error)")
            }
        case .finished:
            break
        }
    }
    
    private func onReceive(_ batch: Repositories) {
        state.repos.items += batch.items
        
        let pages = CGFloat(batch.total_count / RepositoryService.pageSize)
        let roundedPages = ceil(CGFloat(pages))
        state.totalPages = Int(roundedPages + 1)
    }
}

