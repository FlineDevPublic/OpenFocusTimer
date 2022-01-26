import XCTest
import SwiftUI
@testable import Model

final class ColorExtTests: XCTestCase {
  func testHexString() {
    XCTAssertEqual("#FFFFFF", Color.white.hexString)
    XCTAssertEqual("#000000", Color.black.hexString)
  }

  func testInitFromHexBackToHex() {
    let colorHexStrings = ["#FFFFFF", "#000000", "#FF0000", "#00FF00", "#0000FF"]
    for hexString in colorHexStrings {
      let color = Color(hexString: hexString)
      XCTAssertEqual(hexString, color.hexString)
    }
  }
}
