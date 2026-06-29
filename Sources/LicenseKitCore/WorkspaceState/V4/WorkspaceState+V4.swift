//
//  WorkspaceState+V4.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState {
    package struct V4: Decodable {
        package let version: Int
        package let object: Container
    }
}
