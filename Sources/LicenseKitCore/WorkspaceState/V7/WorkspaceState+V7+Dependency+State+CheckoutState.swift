//
//  WorkspaceState+V7+Dependency+State+CheckoutState.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7.Dependency.State {
    package struct CheckoutState: Decodable {
        package let revision: String
        package let branch: String?
        package let version: String?
    }
}
