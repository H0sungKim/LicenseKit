//
//  WorkspaceState+V4+Artifact.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4 {
    package struct Artifact: Decodable {
        package let packageRef: PackageReference
        package let targetName: String
        package let source: Source
        package let path: String
    }
}
