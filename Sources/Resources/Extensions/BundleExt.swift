import Foundation

#warning("extract this to one place and reuse with package name, target name & ModuleToken provided")
extension Foundation.Bundle {
  /// Workaround for making `Bundle.module` work in SwiftUI previews. See: https://stackoverflow.com/a/65789298
  ///
  /// - Returns: The bundle of the target with a path that works in SwiftUI previews, too.
  var swiftUIPreviewsCompatible: Bundle {
    #if DEBUG
      final class ModuleToken {}

      let packageName = "OpenFocusTimer"
      let targetName = "Resources"
      // The name of your local package, prepended by "LocalPackages_" for iOS and "PackageName_" for macOS.
      // NOTE: You may have same PackageName and TargetName.
      #if os(macOS)
        let bundleName = "\(packageName)_\(targetName)"
      #else
        let bundleName = "LocalPackages_\(targetName)"
      #endif

      let candidateUrls: [URL?] = [
        // Bundle should be present here when the package is linked into an App.
        Bundle.main.resourceURL,

        // Bundle should be present here when the package is linked into a framework.
        Bundle(for: ModuleToken.self).resourceURL,

        // For command-line tools.
        Bundle.main.bundleURL,

        // Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/").
        Bundle(for: ModuleToken.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
          .deletingLastPathComponent(),
        Bundle(for: ModuleToken.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
      ]

      for candidateUrl in candidateUrls where candidateUrl != nil {
        let bundlePath: URL = candidateUrl!.appendingPathComponent(bundleName).appendingPathExtension("bundle")
        if let bundle = Bundle(url: bundlePath) { return bundle }
      }

      return self
    #else
      return self
    #endif
  }
}
