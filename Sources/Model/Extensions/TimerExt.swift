import Foundation
import HandySwift

extension Timer {
  public var duration: TimeInterval {
    .seconds(Double(durationInSeconds))
  }

  public convenience init(
    startedAt: Date,
    categories: [Category],
    focusTopic: String,
    duration: TimeInterval = 0,
    pauseCount: Int = 0,
    endedAt: Date? = nil
  ) {
    self.init()

    self.categories = NSSet.init(array: categories)
    self.startedAt = startedAt
    self.focusTopic = focusTopic
    self.durationInSeconds = Int32(duration.seconds)
    self.pauseCount = Int16(pauseCount)
    self.endedAt = endedAt
  }
}
