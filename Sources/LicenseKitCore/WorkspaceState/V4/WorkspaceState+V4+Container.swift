//
//  WorkspaceState+V4+Container.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4 {
    package struct Container: Decodable {
        package let dependencies: [Dependency]
        package let artifacts: [Artifact]
    }
}
