//
//  PackageMetadataExtractor.swift
//  LicenseKit
//
//  Created by 김호성 on 2026.07.02.
//

import Foundation

package struct PackageMetadataExtractor {
    
    package init() {
        
    }
    
    package func extractPackageMetadatas(from workspaceState: WorkspaceState, sourcePackagesURL: URL) throws -> [PackageMetadata] {
        switch workspaceState {
        case let .v4(v4):
            return []
        case let .v5(v5):
            return []
        case let .v6(v6):
            return []
        case let .v7(v7):
            return try extractPackageMetadatas(from: v7, sourcePackagesURL: sourcePackagesURL)
        }
    }
    
    private func extractPackageMetadatas(from workspaceStateV7: WorkspaceState.V7, sourcePackagesURL: URL) throws -> [PackageMetadata] {
        return try workspaceStateV7.object.dependencies.map { dependency in
            try extractPackageMetadata(from: dependency, sourcePackagesURL: sourcePackagesURL)
        }
    }
    
    private func extractPackageMetadata(from dependency: WorkspaceState.V7.Dependency, sourcePackagesURL: URL) throws -> PackageMetadata {
        let packageName: String = dependency.packageRef.name
        
        let packageVersion: String? = switch dependency.state {
        case .fileSystem, .edited:
            nil
        case let .sourceControlCheckout(checkoutState):
            checkoutState.version
        case let .registryDownload(version, _):
            version
        case let .custom(version, _):
            version
        }
        
        let packageURL: String? = switch dependency.packageRef.kind {
        case .root:
            nil
        case .fileSystem:
            nil
        case .localSourceControl:
            nil
        case .remoteSourceControl:
            dependency.packageRef.location
        case .registry:
            dependency.packageRef.location
        }
        
        let packageLicenseText: String = switch dependency.packageRef.kind {
        case .root, .fileSystem, .localSourceControl:
            try getLicenseText(packageDirectoryURL: URL(filePath: dependency.packageRef.location))
        case .remoteSourceControl, .registry:
            try getLicenseText(packageDirectoryURL: sourcePackagesURL.appending(path: "checkouts").appending(path: dependency.subpath))
        }
        
//        let packageLicenseText: String = switch dependency.state {
//        case let .fileSystem(path):
//            getLicenseText(packageDirectoryURL: URL(filePath: path))
//        case .sourceControlCheckout, .registryDownload:
//            getLicenseText(packageDirectoryURL: sourcePackagesURL.appending(path: "checkouts").appending(path: dependency.subpath))
//        case let .edited(path):
//            getLicenseText(packageDirectoryURL: URL(filePath: path))
//        case let .custom(_, path):
//            getLicenseText(packageDirectoryURL: URL(filePath: path))
//        }
        
        return PackageMetadata(
            name: packageName,
            version: packageVersion,
            license: packageLicenseText,
            url: packageURL
        )
    }
    
    private func getLicenseText(packageDirectoryURL: URL) throws -> String {
        let contents = try FileManager.default.contentsOfDirectory(atPath: packageDirectoryURL.path())
        let licenseURL = contents
            .map { packageDirectoryURL.appending(path: $0) }
            .filter { contentURL in
                let fileName = contentURL.deletingPathExtension().lastPathComponent.lowercased()
                guard ["license", "licence"].contains(fileName) else {
                    return false
                }
                var isDirectory: ObjCBool = false
                FileManager.default.fileExists(atPath: contentURL.path(), isDirectory: &isDirectory)
                return isDirectory.boolValue == false
            }
            .first
        guard let licenseURL else {
            throw PackageMetadataExtractorError.licenseNotFound
        }
        let license = try String(contentsOf: licenseURL, encoding: .utf8)
        return license
    }
}

enum PackageMetadataExtractorError: LocalizedError {
    case licenseNotFound
}
