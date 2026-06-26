//
//  WorkspaceState+V4+Container.swift
//  MyCommandPlugin
//
//  Created by Hosung.Kim on 2026.06.26 10:06.
//

import Foundation

extension WorkspaceState.V4 {
    struct Container: Decodable {
        let dependencies: [Dependency]
        let artifacts: [Artifact]
    }
}
