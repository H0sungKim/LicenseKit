//
//  LicenseSettingsBundleTool.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.29.
//

import Foundation
import LicenseKitCore

@main
struct CLI {
    static func main() throws {
        let sourcePackagesURL = URL(filePath: CommandLine.arguments[1])
        let settingsBundleURL = URL(filePath: CommandLine.arguments[2])
        
        try LicenseSettingsBundleTool().writeLicensePlists(sourcePackagesURL: sourcePackagesURL, settingsBundleURL: settingsBundleURL)
    }
}

struct LicenseSettingsBundleTool {
    private let packageMetadataExtractor = PackageMetadataExtractor()
    private let licensePlistSerializer = LicensePlistSerializer()
    
    func writeLicensePlists(sourcePackagesURL: URL, settingsBundleURL: URL) throws {
        // MARK: - WorkspaceState
        let workspaceStateURL = sourcePackagesURL.appending(path: "workspace-state.json")
        let workspaceState = try JSONDecoder().decode(WorkspaceState.self, from: Data(contentsOf: workspaceStateURL))
        
        // MARK: - PackageMetadata
        let packageMetadatas = try packageMetadataExtractor.extractPackageMetadatas(from: workspaceState, sourcePackagesURL: sourcePackagesURL)
        
        // MARK: - License.plist
        let licensePlist = try licensePlistSerializer.serializeLicensePlist(packageMetadatas: packageMetadatas)
        try licensePlist.write(to: settingsBundleURL.appending(path: "License.plist"))
        
        // MARK: - PackageLicense.plist
        try FileManager.default.createDirectory(at: settingsBundleURL.appending(path: "PackageLicense"), withIntermediateDirectories: true)
        try packageMetadatas.forEach { packageMetadata in
            let plist = try licensePlistSerializer.serializePackageLicensePlist(packageMetadata: packageMetadata)
            try plist.write(to: settingsBundleURL.appending(path: "PackageLicense").appending(path: "\(packageMetadata.name).plist"))
        }
    }
}
