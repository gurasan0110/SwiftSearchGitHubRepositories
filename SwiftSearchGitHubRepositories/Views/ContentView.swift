//
//  ContentView.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    
    @State private var observer = RepositoriesObserver()
    
    var body: some View {
        NavigationStack {
            List {
                if let repositories = observer.repositories {
                    Text("\(repositories.totalCount) results")
                    
                    ForEach(repositories.items) { repository in
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
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SearchBar(placeholder: "Search repositories") { q in
                        observer.q = q
                        
                        Task {
                            await observer.searchRepositories()
                        }
                    }
                }
            }
            .refreshable {
                await observer.searchRepositories()
            }
        }
        .alert(isPresented: $observer.isErrorPresented, error: observer.error) {}
    }
}

#Preview {
    ContentView()
}
