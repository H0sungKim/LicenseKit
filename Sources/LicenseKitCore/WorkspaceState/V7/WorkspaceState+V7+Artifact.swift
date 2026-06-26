//
//  WorkspaceState+V7+Artifact.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    struct Artifact: Decodable {
        let packageRef: PackageReference
        let targetName: String
        let source: Source
        let path: String
        let kind: Kind
        
        enum Kind: Decodable {
            case xcframework
            case artifactsArchive
            case typedArtifactsArchive([String])
            case unknown
        }
    }
}
