import PackagePlugin
import Foundation

@main
struct LicenseSettingsBundlePlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments externalArgs: [String]) async throws {
        Diagnostics.warning("Command only supported as Xcode command")
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension LicenseSettingsBundlePlugin: XcodeCommandPlugin {
    // Entry point for command plugins applied to Xcode projects.
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        print("Hello, World!")
        
        let sourcePackagesURL = try getSourcePackagesURL(context.pluginWorkDirectoryURL)
//        let workspaceState = try JSONDecoder().decode(WorkspaceState.self, from: Data(contentsOf: workspaceStateURL))
        
//        print(workspaceState)
        
//        let licensePlist = try PropertyListSerialization.data(
//            fromPropertyList: [
//                "PreferenceSpecifiers": [
//                    [
//                        "Type": "PSGroupSpecifier",
//                        "Title": "Test"
//                    ]
//                ]
//            ],
//            format: .xml,
//            options: 0
//        )
        
        if let settingsBundleURL = findSettingsBundle(from: context.xcodeProject.directoryURL) {
//            try licensePlist.write(to: settingsBundleURL.appending(component: "License.plist"))
            let tool = try context.tool(named: "LicenseSettingsBundleGenerator")
            try tool.run(arguments: [
                sourcePackagesURL.path(),
                settingsBundleURL.path()
            ])
        }
        
        
    }
    
    func findSettingsBundle(from root: URL) -> URL? {
        guard let enumerator = FileManager.default.enumerator(
            at: root,
            includingPropertiesForKeys: nil
        ) else {
            return nil
        }
        
        for case let url as URL in enumerator {
            if url.lastPathComponent == "Settings.bundle" {
                return url
            }
        }
        return nil
    }
    
    func existsSourcePackages(in url: URL) throws -> Bool {
        guard url.isFileURL,
              url.pathComponents.count > 1,
              let isDirectory = try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory else {
            throw SourcePackagesNotFoundError()
        }
        let existsSourcePackagesInDirectory = FileManager.default
            .fileExists(atPath: url.appending(path: "SourcePackages").path())
        return isDirectory && existsSourcePackagesInDirectory
    }

    func getSourcePackagesURL(_ pluginWorkDirectory: URL) throws -> URL {
//        if let sourcePackagesPath = ProcessInfo.processInfo.environment["PLL_SOURCE_PACKAGES_PATH"] {
//            print(URL(filePath: sourcePackagesPath))
//            return URL(filePath: sourcePackagesPath)
//        }

        var tmpURL = pluginWorkDirectory.absoluteURL

        while try !existsSourcePackages(in: tmpURL) {
            tmpURL.deleteLastPathComponent()
        }
        tmpURL.append(path: "SourcePackages")
        return tmpURL
    }
    
    struct SourcePackagesNotFoundError: Error & CustomStringConvertible {
        let description: String = "SourcePackages not found"
    }
    
    
}

private extension PluginContext.Tool {
    func run(arguments: [String]) throws {
        let pipe = Pipe()
        let process = Process()
        process.executableURL = URL(fileURLWithPath: url.path)
        process.arguments = arguments
        process.standardError = pipe

        try process.run()
        process.waitUntilExit()

        if process.terminationReason == .exit && process.terminationStatus == 0 {
            return
        }

        let data = try pipe.fileHandleForReading.readToEnd()
        let stderr = data.flatMap { String(data: $0, encoding: .utf8) }

        if let stderr {
            throw RunError(description: stderr)
        } else {
            let problem = "\(process.terminationReason.rawValue):\(process.terminationStatus)"
            throw RunError(description: "\(name) invocation failed: \(problem)")
        }
    }
}

private struct RunError: Error {
    let description: String
}

#endif
