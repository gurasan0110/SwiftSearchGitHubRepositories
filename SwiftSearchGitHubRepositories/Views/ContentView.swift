//
//  ContentView.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        @Bindable var observer = RepositoriesObserver.shared
        
        VStack {
            SearchBar(placeholder: "Search repositories") { q in
                observer.q = q
                
                Task {
                    await observer.searchRepositories()
                }
            }
            
            RepositoryList()
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
