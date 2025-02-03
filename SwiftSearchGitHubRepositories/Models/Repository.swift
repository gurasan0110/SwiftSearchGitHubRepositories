//
//  Repository.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import Foundation

struct Repository: Decodable, Identifiable {
    let id: Int
    let fullName: String
    let owner: Owner?
    let htmlURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
    }
}
