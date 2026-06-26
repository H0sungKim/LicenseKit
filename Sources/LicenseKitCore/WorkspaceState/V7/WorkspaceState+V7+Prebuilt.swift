//
//  WorkspaceState+V7+Prebuilt.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    struct Prebuilt: Decodable {
        let identity: String
        let version: String
        let libraryName: String
        let path: String
        let checkoutPath: String?
        let products: [String]
        let includePath: [String]?
        let cModules: [String]
    }
}
