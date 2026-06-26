//
//  WorkspaceState+V7+Container.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    struct Container: Decodable {
        let dependencies: [Dependency]
        let artifacts: [Artifact]
        let prebuilts: [Prebuilt]
    }
}
