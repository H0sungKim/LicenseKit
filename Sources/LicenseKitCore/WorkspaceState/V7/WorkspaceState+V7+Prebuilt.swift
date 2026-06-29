//
//  WorkspaceState+V7+Prebuilt.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    package struct Prebuilt: Decodable {
        package let identity: String
        package let version: String
        package let libraryName: String
        package let path: String
        package let checkoutPath: String?
        package let products: [String]
        package let includePath: [String]?
        package let cModules: [String]
    }
}
