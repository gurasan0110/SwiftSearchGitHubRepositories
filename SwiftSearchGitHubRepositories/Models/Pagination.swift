//
//  Pagination.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

struct Pagination<T: Decodable>: Decodable {
    let totalCount: Int
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
