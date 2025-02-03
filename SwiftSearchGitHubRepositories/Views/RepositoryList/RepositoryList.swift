//
//  RepositoryList.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import SwiftUI

struct RepositoryList: View {
    var body: some View {
        if let repositories = RepositoriesObserver.shared.repositories {
            List {
                Text("\(repositories.totalCount) results")
                
                ForEach(repositories.items) { repository in
                    RepositoryListItem(repository: repository)
                }
            }
        } else {
            Spacer()
        }
    }
}

#Preview {
    RepositoryList()
}
