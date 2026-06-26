import PackagePlugin
import struct Foundation.URL
import class Foundation.FileManager

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

@main
struct LicenseSettingsBundlePlugin: XcodeCommandPlugin {
    // Entry point for command plugins applied to Xcode projects.
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        print("Hello, World!")
        print(context.xcodeProject.directoryURL)
        
        
        
//        if let settingsBundleURL = findSettingsBundle(from: context.xcodeProject.directoryURL) {
//            try "XcodePluginContext".data(using: .utf8)?.write(to: settingsBundleURL.appending(component: "test.txt"))
//        }
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
}
#endif
