import Foundation
import HandySwift
import CoreData

extension FocusTimer {
  public var runningDuration: TimeInterval {
    .seconds(Double(runningDurationInSeconds))
  }

  public var timerRunoutDuration: TimeInterval {
    .seconds(Double(timerRunoutDurationInSeconds))
  }

  public var timeLeft: TimeInterval {
    timerRunoutDuration - runningDuration
  }

  public convenience init(
    context: NSManagedObjectContext,
    startedAt: Date,
    categories: [Category],
    focusTopic: String,
    timerRunoutDuration: TimeInterval,
    running: Bool = true,
    runningDuration: TimeInterval = 0,
    pauseCount: Int = 0,
    endedAt: Date? = nil
  ) {
    self.init(context: context)

    self.categories = NSSet.init(array: categories)
    self.startedAt = startedAt
    self.focusTopic = focusTopic
    self.timerRunoutDurationInSeconds = Int32(timerRunoutDuration.seconds)
    self.running = running
    self.runningDurationInSeconds = Int32(runningDuration.seconds)
    self.pauseCount = Int16(pauseCount)
    self.endedAt = endedAt
  }
}
