//
//  RepositoriesObserver.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import Foundation

@Observable
class RepositoriesObserver {
    static let shared = RepositoriesObserver()
    
    var repositories: Pagination<Repository>?
    var q: String?
    var isErrorPresented = false
    var error: Error?
    
    private let client = SearchClient()
    
    private init() {}
    
    @MainActor
    func searchRepositories() async {
        guard let q else {
            print("q is nil")
            return
        }
        
        do {
            repositories = try await client.searchRepositories(q)
        } catch {
            isErrorPresented = true
            self.error = .searchClient(error)
        }
    }
    
    enum Error: LocalizedError {
        case searchClient(SearchClient.Error)
        
        var errorDescription: String? {
            switch self {
            case .searchClient(let error):
                error.errorDescription
            }
        }
    }
}
