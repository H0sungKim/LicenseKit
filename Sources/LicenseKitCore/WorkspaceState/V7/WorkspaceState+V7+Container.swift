//
//  WorkspaceState+V7+Container.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    package struct Container: Decodable {
        package let dependencies: [Dependency]
        package let artifacts: [Artifact]
        package let prebuilts: [Prebuilt]
    }
}
