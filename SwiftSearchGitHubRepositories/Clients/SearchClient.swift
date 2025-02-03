//
//  SearchClient.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import Foundation

struct SearchClient {
    func searchRepositories(_ q: String) async throws(Error) -> Pagination<Repository> {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(q)") else {
            throw Error.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpURLResponse = urlResponse as? HTTPURLResponse {
                switch (httpURLResponse.statusCode) {
                case 304:
                    throw Error.notModified
                case 422:
                    throw Error.unprocessableContent
                case 503:
                    throw Error.serviceUnavailable
                default:
                    break
                }
            }
            
            return try JSONDecoder().decode(Pagination.self, from: data)
        } catch {
            throw Error.unknown
        }
    }
    
    enum Error: LocalizedError {
        case invalidURL
        case notModified
        case unprocessableContent
        case serviceUnavailable
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                "Invalid url"
            case .notModified:
                "Not modified"
            case .unprocessableContent:
                "Validation failed, or the endpoint has been spammed."
            case .serviceUnavailable:
                "Service unavailable"
            case .unknown:
                "Unknown"
            }
        }
    }
}
