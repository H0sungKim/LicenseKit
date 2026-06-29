//
//  WorkspaceState+V7+Artifact+Source.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7.Artifact {
    package enum Source: Decodable {
        case remote(url: String, checksum: String)
        case local(checksum: String? = nil)
        
        package init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let kind = try container.decode(String.self, forKey: .type)
            switch kind {
            case "local":
                let checksum = try container.decodeIfPresent(String.self, forKey: .checksum)
                self = .local(checksum: checksum)
            case "remote":
                let url = try container.decode(String.self, forKey: .url)
                let checksum = try container.decode(String.self, forKey: .checksum)
                self = .remote(url: url, checksum: checksum)
            default:
                throw StringError("unknown artifact source \(kind)")
            }
        }
        
        enum CodingKeys: CodingKey {
            case type
            case url
            case checksum
        }
    }
}
