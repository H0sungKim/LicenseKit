//
//  PackageLicensePlistFactory.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.29.
//

import Foundation
import LicenseKitCore

struct PackageLicensePlistFactory {
    
    // name, license path, version
    
//    <?xml version="1.0" encoding="UTF-8"?>
//    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
//    <plist version="1.0">
//    <dict>
//        <key>PreferenceSpecifiers</key>
//        <array>
//            <dict>
//                <key>FooterText</key>
//                <string>https://github.com/apple/swift-collections</string>
//                <key>Title</key>
//                <string>Alamofire (1.0.0)</string>
//                <key>Type</key>
//                <string>PSGroupSpecifier</string>
//            </dict>
//            <dict>
//                <key>FooterText</key>
//                <string>Copyright (c) 2014-2022 Alamofire Software Foundation (http://alamofire.org/)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the &quot;Software&quot;), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.
//    </string>
//                <key>License</key>
//                <string>MIT</string>
//                <key>Type</key>
//                <string>PSGroupSpecifier</string>
//            </dict>
//        </array>
//    </dict>
//    </plist>

    
    func makePackageLicensePlists(workspaceState: WorkspaceState, sourcePackagesURL: URL, to filePath: URL) throws {
        try FileManager.default.createDirectory(at: filePath.appending(path: "PackageLicense"), withIntermediateDirectories: true)
        switch workspaceState {
        case let .v4(v4):
            break
        case let .v5(v5):
            break
        case let .v6(v6):
            break
        case let .v7(v7):
            try makePackageLicensePlists(workspaceState: v7, sourcePackagesURL: sourcePackagesURL, to: filePath)
        }
    }
    
    func makePackageLicensePlists(workspaceState: WorkspaceState.V7, sourcePackagesURL: URL, to filePath: URL) throws {
        print(workspaceState.object.dependencies)
        for dependency in workspaceState.object.dependencies {
            try makePackageLicensePlist(dependency: dependency, sourcePackagesURL: sourcePackagesURL, to: filePath)
        }
    }
    
    func makePackageLicensePlist(dependency: WorkspaceState.V7.Dependency, sourcePackagesURL: URL, to filePath: URL) throws {
        var title = [
            "Type": "PSGroupSpecifier",
            "FooterText": dependency.packageRef.location,
        ]
        if case let .sourceControlCheckout(checkoutState) = dependency.state, let version = checkoutState.version {
            title["Title"] = "\(dependency.packageRef.name) (\(version))"
        } else {
            title["Title"] = dependency.packageRef.name
        }
        
        let license = [
            "Type": "PSGroupSpecifier",
            // FIXME: Local package 분기 처리
            "FooterText": getLicense(sourcePackagesURL: sourcePackagesURL, subpath: dependency.subpath) ?? ""
        ]
        let propertyList = [
            "PreferenceSpecifiers": [title, license]
        ]
        let packageLicensePlist = try PropertyListSerialization.data(
            fromPropertyList: propertyList,
            format: .xml,
            options: 0
        )
        try packageLicensePlist.write(to: filePath.appending(path: "PackageLicense").appending(path: "\(dependency.packageRef.name).plist"))
    }
    
    func getLicense(sourcePackagesURL: URL, subpath: String) -> String? {
        let directoryURL = sourcePackagesURL.appending(path: "checkouts").appending(path: subpath)
        let contents = try? FileManager.default.contentsOfDirectory(atPath: directoryURL.path())
        let licenseURL = contents?
            .map { directoryURL.appending(path: $0) }
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
        guard let licenseURL, let license = try? String(contentsOf: licenseURL, encoding: .utf8) else {
            return nil
        }
        return license
    }
    
}
