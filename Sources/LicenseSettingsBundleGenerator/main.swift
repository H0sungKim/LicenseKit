//
//  File.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.29.
//

import Foundation
import LicenseKitCore

let sourcePackagesURL = URL(filePath: CommandLine.arguments[1])
let workspaceStateURL = sourcePackagesURL.appending(path: "workspace-state.json")
let settingsBundleURL = URL(filePath: CommandLine.arguments[2])

let workspaceState = try JSONDecoder().decode(WorkspaceState.self, from: Data(contentsOf: workspaceStateURL))

try LicensePlistFactory().makeLicensePlist(workspaceState: workspaceState, to: settingsBundleURL)
try PackageLicensePlistFactory().makePackageLicensePlists(workspaceState: workspaceState, sourcePackagesURL: sourcePackagesURL, to: settingsBundleURL)
