//
//  WorkspaceState+V4+Artifact.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4 {
    struct Artifact: Decodable {
        let packageRef: PackageReference
        let targetName: String
        let source: Source
        let path: String
    }
}
