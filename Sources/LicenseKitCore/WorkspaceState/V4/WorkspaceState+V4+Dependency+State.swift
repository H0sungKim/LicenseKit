//
//  WorkspaceState+V4+Dependency+State.swift
//  MyCommandPlugin
//
//  Created by Hosung.Kim on 2026.06.26 10:06.
//

import Foundation

extension WorkspaceState.V4.Dependency {
    enum State: Decodable {
        case fileSystem
        case sourceControlCheckout(checkoutState: CheckoutState)
        case edited(path: String?)
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let kind = try container.decode(String.self, forKey: .name)
            switch kind {
            case "local":
                self = .fileSystem
            case "checkout":
                let checkout = try container.decode(CheckoutState.self, forKey: .checkoutState)
                self = .sourceControlCheckout(checkoutState: checkout)
            case "edited":
                let path = try container.decode(String?.self, forKey: .path)
                self = .edited(path: path)
            default:
                throw StringError("unknown dependency state \(kind)")
            }
        }
        
        enum CodingKeys: CodingKey {
            case name
            case path
            case checkoutState
        }
    }
}
