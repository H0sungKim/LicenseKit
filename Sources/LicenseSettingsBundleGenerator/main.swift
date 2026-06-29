//
//  File.swift
//  LicenseKit
//
//  Created by Hosung.Kim on 2026.06.29.
//

import Foundation
import LicenseKitCore

let workspaceStateURLPath = CommandLine.arguments[1]
let settingsBundleURLPath = CommandLine.arguments[2]

let workspaceState = try JSONDecoder().decode(WorkspaceState.self, from: Data(contentsOf: URL(filePath: workspaceStateURLPath)))

try LicensePlistFactory().makeLicensePlist(workspaceState: workspaceState).write(to: URL(filePath: settingsBundleURLPath).appending(path: "License.plist"))

//switch workspaceState {
//case let .v4(v4):
//    break
//case let .v5(v5):
//    break
//case let .v6(v6):
//    break
//case let .v7(v7):
//    
//    try "\(v7.object.dependencies)".data(using: .utf8)?.write(to: URL(filePath: settingsBundleURLPath).appending(path: "test.txt"))
//}
