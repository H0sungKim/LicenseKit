//
//  WorkspaceState+V4+Container.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4 {
    struct Container: Decodable {
        let dependencies: [Dependency]
        let artifacts: [Artifact]
    }
}
