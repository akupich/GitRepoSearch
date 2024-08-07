//
//  GitRepoSearchApp.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import SwiftUI

@main
struct GitRepoSearchApp: App {
    var body: some Scene {
        WindowGroup {
            SearchRepoConfigurator.configureSearchRepoView()
        }
    }
}
