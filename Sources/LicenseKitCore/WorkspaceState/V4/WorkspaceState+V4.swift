//
//  WorkspaceState+V4.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState {
    struct V4: Decodable {
        let version: Int
        let object: Container
    }
}
