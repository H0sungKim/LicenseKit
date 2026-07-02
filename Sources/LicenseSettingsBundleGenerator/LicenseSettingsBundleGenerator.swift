//
//  main.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.29.
//

import Foundation
import LicenseKitCore

@main
struct LicenseSettingsBundleGenerator {
    static func main() throws {
        
        let packageMetadataExtractor = PackageMetadataExtractor()
        let plistSerializer = PlistSerializer()
        
        // MARK: - Arguments
        let sourcePackagesURL = URL(filePath: CommandLine.arguments[1])
        let settingsBundleURL = URL(filePath: CommandLine.arguments[2])
        
        // MARK: - WorkspaceState
        let workspaceStateURL = sourcePackagesURL.appending(path: "workspace-state.json")
        let workspaceState = try JSONDecoder().decode(WorkspaceState.self, from: Data(contentsOf: workspaceStateURL))
        
        // MARK: - PackageMetadata
        let packageMetadatas = try packageMetadataExtractor.extractPackageMetadatas(from: workspaceState, sourcePackagesURL: sourcePackagesURL)
        
        // MARK: - License.plist
        let licensePlist = try plistSerializer.serializeLicensePlist(packageMetadatas: packageMetadatas)
        try licensePlist.write(to: settingsBundleURL.appending(path: "License.plist"))
        
        // MARK: - PackageLicense.plist
        try FileManager.default.createDirectory(at: settingsBundleURL.appending(path: "PackageLicense"), withIntermediateDirectories: true)
        try packageMetadatas.forEach { packageMetadata in
            let plist = try plistSerializer.serializePackageLicensePlist(packageMetadata: packageMetadata)
            try plist.write(to: settingsBundleURL.appending(path: "PackageLicense").appending(path: "\(packageMetadata.name).plist"))
        }
    }
}
