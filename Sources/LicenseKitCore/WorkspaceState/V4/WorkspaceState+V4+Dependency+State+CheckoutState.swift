//
//  WorkspaceState+V4+Dependency+State+CheckoutState.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4.Dependency.State {
    struct CheckoutState: Decodable {
        let revision: String
        let branch: String?
        let version: String?
    }
}
