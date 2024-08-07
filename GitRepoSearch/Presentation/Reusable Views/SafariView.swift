//
//  SafariView.swift
//  GitRepoSearch
//
//  Created by Andriy Kupich on 13.09.2021.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    var url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let safariView = SFSafariViewController(url: url)
        return safariView
    }

    func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: UIViewControllerRepresentableContext<SafariView>) {}
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        return SafariView(url: URL(string: "https://www.google.com")!)
            .ignoresSafeArea()
    }
}
