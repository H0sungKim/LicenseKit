//
//  WorkspaceState+V4+Dependency.swift
//  MyCommandPlugin
//
//  Created by Hosung.Kim on 2026.06.26 10:06.
//

import Foundation

extension WorkspaceState.V4 {
    struct Dependency: Decodable {
        let packageRef: PackageReference
        let state: State
        let subpath: String
        let basedOn: Dependency?
    }
}
