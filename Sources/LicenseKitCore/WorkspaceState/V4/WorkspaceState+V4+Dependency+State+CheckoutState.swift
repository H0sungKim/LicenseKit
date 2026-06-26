//
//  WorkspaceState+V4+Dependency+State+CheckoutState.swift
//  MyCommandPlugin
//
//  Created by Hosung.Kim on 2026.06.26 10:06.
//

import Foundation

extension WorkspaceState.V4.Dependency.State {
    struct CheckoutState: Decodable {
        let revision: String
        let branch: String?
        let version: String?
    }
}
