//
//  LicensePlistSerializer.swift
//  LicenseKit
//
//  Created by 김호성 on 2026.07.02.
//

import Foundation
import LicenseKitCore

struct LicensePlistSerializer {
    
    func serializeLicensePlist(packageMetadatas: [PackageMetadata]) throws -> Data {
        let propertyListHeader = [
            "Type": "PSGroupSpecifier",
            "Title": "License"
        ]
        let packageChildPanes: [[String: String]] = packageMetadatas.map { packageMetadata in
            makePackageChildPanes(packageMetadata: packageMetadata)
        }
        
        let propertyList = [
            "PreferenceSpecifiers": [propertyListHeader] + packageChildPanes
        ]
        let licensePlist = try PropertyListSerialization.data(
            fromPropertyList: propertyList,
            format: .xml,
            options: 0
        )
        return licensePlist
    }
    
    private func makePackageChildPanes(packageMetadata: PackageMetadata) -> [String: String] {
        return [
            "Title": packageMetadata.name,
            "Type": "PSChildPaneSpecifier",
            "File": "PackageLicense/\(packageMetadata.name)",
        ]
    }
    
    func serializePackageLicensePlist(packageMetadata: PackageMetadata) throws -> Data {
        var title = ["Type": "PSGroupSpecifier"]
        if let packageVersion = packageMetadata.version {
            title["Title"] = "\(packageMetadata.name) (\(packageVersion))"
        } else {
            title["Title"] = packageMetadata.name
        }
        if let packageURL = packageMetadata.url {
            title["FooterText"] = packageURL
        }
        let license = [
            "Type": "PSGroupSpecifier",
            "FooterText": packageMetadata.license
        ]
        let propertyList = [
            "PreferenceSpecifiers": [title, license]
        ]
        let packageLicensePlist = try PropertyListSerialization.data(
            fromPropertyList: propertyList,
            format: .xml,
            options: 0
        )
        return packageLicensePlist
    }
}
