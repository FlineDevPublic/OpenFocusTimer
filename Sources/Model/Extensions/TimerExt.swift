import Foundation
import HandySwift

extension Timer {
  public var duration: TimeInterval {
    .seconds(Double(durationInSeconds))
  }

  public convenience init() {
    #warning("not yet implemented")
    fatalError("continue here")
  }
}
