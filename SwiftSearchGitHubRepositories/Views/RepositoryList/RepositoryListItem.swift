//
//  RepositoryListItem.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import SwiftUI

struct RepositoryListItem: View {
    let repository: Repository
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        Button {
            openURL(repository.htmlURL)
        } label: {
            HStack {
                AsyncImage(url: repository.owner?.avatarURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 32, height: 32)
                
                Text(repository.fullName)
            }
        }
    }
}
