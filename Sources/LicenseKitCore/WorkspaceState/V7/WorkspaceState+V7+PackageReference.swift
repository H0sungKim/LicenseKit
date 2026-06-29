//
//  WorkspaceState+V7+PackageReference.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    package struct PackageReference: Decodable {
        package let identity: String
        package let kind: Kind
        package let location: String
        package let name: String
        
        package enum Kind: String, Decodable {
            case root
            case fileSystem
            case localSourceControl
            case remoteSourceControl
            case registry
        }
    }
}
