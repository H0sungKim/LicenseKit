import PackagePlugin
import class Foundation.FileManager
import struct Foundation.URL

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

@main
struct LicenseSwiftSourcePlugin: XcodeBuildToolPlugin {
    // Entry point for creating build commands for targets in Xcode projects.
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        // Find the code generator tool to run (replace this with the actual one).
        print("XcodePluginContext: \(context.xcodeProject.directoryURL) \(context.pluginWorkDirectoryURL)")
        let generatorTool = try context.tool(named: "License")
        
        // Construct a build command for each source file with a particular suffix.
        
        let outputDirectoryPath = context.pluginWorkDirectoryURL.appending(component: "plugin-output")
        try FileManager.default.createDirectory(at: outputDirectoryPath, withIntermediateDirectories: true)
        
        let command = Command.buildCommand(
            displayName: "XcodeBuildToolPlugin Hosung.Kim",
            executable: generatorTool.url,
            arguments: [
                context.xcodeProject.directoryURL.absoluteURL.path(),
                outputDirectoryPath.absoluteURL.path(),
            ],
            outputFiles: [
//                context.pluginWorkDirectoryURL.appending(path: "output.txt")
            ]
        )
        return [command]
    }
}

#endif
