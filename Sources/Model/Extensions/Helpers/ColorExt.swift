// Adapted from: https://github.com/yannickl/DynamicColor/blob/master/Sources/SwiftUI/Color.swift

import SwiftUI

#if os(macOS)
   import AppKit
#else
   import UIKit
#endif

extension Color {
   /// Returns the HEX representation of the `Color` object.
   public var hexString: String {
      #if os(macOS)
         let kitTypedColor = NSColor(self)
      #else
         let kitTypedColor = UIColor(self)
      #endif
      let components = kitTypedColor.cgColor.components

      let red: CGFloat
      let green: CGFloat
      let blue: CGFloat

      if let components = components {
         if components.count == 2 {
            red = components[0]
            green = components[0]
            blue = components[0]
         } else if components.count == 4 {
            red = components[0]
            green = components[1]
            blue = components[2]
         } else {
            red = 0
            green = 0
            blue = 0
         }
      } else {
         red = 0
         green = 0
         blue = 0
      }

      return String(
         format: "#%02lX%02lX%02lX",
         lroundf(Float(red * 255)),
         lroundf(Float(green * 255)),
         lroundf(Float(blue * 255))
      )
   }

   /// Creates a color from an hex string (e.g. "#3498db"). The RGBA string are also supported (e.g. "#3498dbff").
   ///
   /// If the given hex string is invalid the initialiser will create a black color.
   ///
   /// - Parameter hexString: A hexa-decimal color string representation.
   public init(
      hexString: String
   ) {
      let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
      let scanner = Scanner(string: hexString)
      scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")

      var color: UInt64 = 0

      if scanner.scanHexInt64(&color) {
         self.init(hex: color, useOpacity: hexString.count > 7)
      } else {
         self.init(hex: 0x000000)
      }
   }

   /// Creates a color from an hex integer (e.g. 0x3498db).
   ///
   /// - Parameters:
   ///   - hex: A hexa-decimal UInt64 that represents a color.
   ///   - opacityChannel: If true the given hex-decimal UInt64 includes the opacity channel (e.g. 0xFF0000FF).
   private init(
      hex: UInt64,
      useOpacity opacityChannel: Bool = false
   ) {
      let mask = UInt64(0xFF)
      let cappedHex = !opacityChannel && hex > 0xffffff ? 0xffffff : hex

      let redHex = cappedHex >> (opacityChannel ? 24 : 16) & mask
      let greenHex = cappedHex >> (opacityChannel ? 16 : 8) & mask
      let blueHex = cappedHex >> (opacityChannel ? 8 : 0) & mask
      let opacityHex = opacityChannel ? cappedHex & mask : 255

      let red = Double(redHex) / 255.0
      let green = Double(greenHex) / 255.0
      let blue = Double(blueHex) / 255.0
      let opacity = Double(opacityHex) / 255.0

      self.init(red: red, green: green, blue: blue, opacity: opacity)
   }
}
