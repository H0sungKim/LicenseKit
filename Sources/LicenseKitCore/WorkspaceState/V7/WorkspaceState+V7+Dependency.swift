//
//  WorkspaceState+V7+Dependency.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V7 {
    struct Dependency: Decodable {
        let packageRef: PackageReference
        let state: State
        let subpath: String
        let basedOn: IndirectDependency?
    }
    
    indirect enum IndirectDependency: Decodable {
        case value(Dependency)
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dependency = try container.decode(Dependency.self)
            self = .value(dependency)
        }
    }
}
