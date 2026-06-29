//
//  WorkspaceState+V4+Dependency.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.26.
//

import Foundation

extension WorkspaceState.V4 {
    package struct Dependency: Decodable {
        package let packageRef: PackageReference
        package let state: State
        package let subpath: String
        package let basedOn: IndirectDependency?
    }
    
    package indirect enum IndirectDependency: Decodable {
        case value(Dependency)
        
        package init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dependency = try container.decode(Dependency.self)
            self = .value(dependency)
        }
    }
}
