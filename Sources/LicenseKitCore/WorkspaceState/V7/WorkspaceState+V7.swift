//
//  WorkspaceState+V7.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState {
    struct V7: Decodable {
        let version: Int
        let object: Container
    }
}
