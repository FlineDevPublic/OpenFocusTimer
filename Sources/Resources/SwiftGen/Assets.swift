// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
#endif


internal typealias Colors = Asset.Colors
internal typealias Images = Asset.Images

internal enum Asset {
  internal enum Colors {
    internal static let sample = UIColor(named: "Sample", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
  }
  internal enum Images {
    internal static let sample = UIImage(named: "Sample", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
  }
}


private final class BundleToken {}
