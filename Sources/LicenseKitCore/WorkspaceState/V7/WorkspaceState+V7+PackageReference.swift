//
//  WorkspaceState+V7+PackageReference.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    struct PackageReference: Decodable {
        let identity: String
        let kind: Kind
        let location: String
        let name: String
        
        enum Kind: String, Decodable {
            case root
            case fileSystem
            case localSourceControl
            case remoteSourceControl
            case registry
        }
    }
}
