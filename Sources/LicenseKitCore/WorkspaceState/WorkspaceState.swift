//
//  WorkspaceState.swift
//  MyCommandPlugin
//
//  Created by Hosung.Kim on 2026.06.25 18:59.
//

import Foundation

enum WorkspaceState {
    case v4(V4)
    case v5(V5)
    case v6(V6)
    case v7(V7)
}

// MARK: - Decodable
extension WorkspaceState: Decodable {
    enum CodingKeys: CodingKey {
        case version
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let version = try container.decode(Int.self, forKey: .version)
        
        switch version {
        case 1, 2, 3, 4:
            self = try .v4(V4(from: decoder))
        case 5:
            self = try .v5(V5(from: decoder))
        case 6:
            self = try .v6(V6(from: decoder))
        case 7:
            self = try .v7(V7(from: decoder))
        default:
            throw UnsupportedVersionError(version: version)
        }
    }
    
    struct UnsupportedVersionError: LocalizedError {
        let version: Int
        
        var errorDescription: String? {
            return "unknown 'WorkspaceStateStorage' version '\(version)'"
        }
    }
}
