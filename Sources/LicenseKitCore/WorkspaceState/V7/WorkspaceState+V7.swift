//
//  WorkspaceState+V7.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState {
    package struct V7: Decodable {
        package let version: Int
        package let object: Container
    }
}
