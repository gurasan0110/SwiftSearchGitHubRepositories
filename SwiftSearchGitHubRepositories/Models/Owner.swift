//
//  Owner.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import Foundation

struct Owner: Decodable {
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
