//
//  LicensePlistFactory.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.29.
//

import Foundation
import LicenseKitCore

struct LicensePlistFactory {
    
    func makeLicensePlist(workspaceState: WorkspaceState, to filePath: URL) throws {
        let propertyListHeader = [
            "Type": "PSGroupSpecifier",
            "Title": "License"
        ]
        let packageChildPanes: [[String: String]] = makePackageChildPanes(workspaceState: workspaceState)
        
        let propertyList = [
            "PreferenceSpecifiers": [propertyListHeader] + packageChildPanes
        ]
        let licensePlist = try PropertyListSerialization.data(
            fromPropertyList: propertyList,
            format: .xml,
            options: 0
        )
        try licensePlist.write(to: filePath.appending(path: "License.plist"))
    }
    
    private func makePackageChildPanes(workspaceState: WorkspaceState) -> [[String: String]] {
        switch workspaceState {
        case let .v4(v4):
            return []
        case let .v5(v5):
            return []
        case let .v6(v6):
            return []
        case let .v7(v7):
            return makePackageChildPanes(workspaceStateV7: v7)
        }
    }
    
    private func makePackageChildPanes(workspaceStateV7: WorkspaceState.V7) -> [[String: String]] {
        return workspaceStateV7.object.dependencies.map { dependency in
            [
                "Title": dependency.packageRef.name,
                "Type": "PSChildPaneSpecifier",
                "File": "PackageLicense/\(dependency.packageRef.name)",
            ]
        }
    }
    
//    func aa(workspaceState: WorkspaceState.V7) -> [String: String] {
//        workspaceStateV7.object.dependencies
//    }
//    
//    func aaaa(dependency: WorkspaceState.V7.Dependency) -> Data {
//        let packageName = dependency.packageRef.name
//        switch dependency.state {
//        case let .fileSystem(path):
//            <#code#>
//        case let .sourceControlCheckout(checkoutState):
//            
//        case let .registryDownload(version, scmUrl):
//            <#code#>
//        case let .edited(path):
//            <#code#>
//        case let .custom(version, path):
//            <#code#>
//        }
//    }
}
