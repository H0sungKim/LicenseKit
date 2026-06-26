//
//  WorkspaceState+V4+PackageReference.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4 {
    struct PackageReference: Decodable {
        let identity: String
        let kind: String
        let location: String
        let name: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.identity = try container.decode(String.self, forKey: .identity)
            self.kind = try container.decode(String.self, forKey: .kind)
            self.name = try container.decode(String.self, forKey: .name)
            if let location = try container.decodeIfPresent(String.self, forKey: .location) {
                self.location = location
            } else if let path = try container.decodeIfPresent(String.self, forKey: .path) {
                self.location = path
            } else {
                throw StringError("invalid package ref, missing location and path")
            }
        }
        
        enum CodingKeys: CodingKey {
            case identity
            case kind
            case location
            case path
            case name
        }
    }
}
