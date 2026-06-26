//
//  WorkspaceState+V7+Dependency+State.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7.Dependency {
    enum State: Decodable {
        case fileSystem(path: String)
        case sourceControlCheckout(checkoutState: CheckoutState)
        case registryDownload(version: String, scmUrl: String?)
        case edited(path: String?)
        case custom(version: String, path: String)
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let kind = try container.decode(String.self, forKey: .name)
            switch kind {
            case "local", "fileSystem":
                let path = try container.decode(String.self, forKey: .path)
                self = .fileSystem(path: path)
            case "checkout", "sourceControlCheckout":
                let checkout = try container.decode(CheckoutState.self, forKey: .checkoutState)
                self = .sourceControlCheckout(checkoutState: checkout)
            case "registryDownload":
                let version = try container.decode(String.self, forKey: .version)
                let urlString = try container.decodeIfPresent(String.self, forKey: .scmUrl)
                self = .registryDownload(version: version, scmUrl: urlString)
            case "edited":
                let path = try container.decode(String?.self, forKey: .path)
                self = .edited(path: path)
            case "custom":
                let version = try container.decode(String.self, forKey: .version)
                let path = try container.decode(String.self, forKey: .path)
                self = .custom(version: version, path: path)
            default:
                throw StringError("unknown dependency state \(kind)")
            }
        }
        
        enum CodingKeys: CodingKey {
            case name
            case path
            case version
            case scmUrl
            case checkoutState
        }
    }
}
