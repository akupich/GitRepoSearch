//
//  SearchRepoRouter.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import SafariServices
import SwiftUI

final class SearchRepoRouter {
    public static func destinationForTappedRepo(repo: Repository) {
        if let url = URL(string: repo.html_url) {
            UIApplication.shared.open(url)
        }
    }
}
