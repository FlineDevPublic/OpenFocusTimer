import Foundation
import HandySwift
import CoreData
import OrderedCollections

extension FocusTimer {
  /// Default focus timer length.
  #if DEBUG
    public static var defaultTimerRunoutDuration: TimeInterval = .seconds(5)
  #else
    public static var defaultTimerRunoutDuration: TimeInterval = .minutes(25)
  #endif

  public var runningDuration: TimeInterval {
    .seconds(Double(runningDurationInSeconds))
  }

  public var timerRunoutDuration: TimeInterval {
    .seconds(Double(timerRunoutDurationInSeconds))
  }

  public var timeLeft: TimeInterval {
    timerRunoutDuration - runningDuration
  }

  public var completed: Bool {
    self.endedAt != nil
  }

  public var typedProgressPoints: [RichTextEntry] {
    self.progressPoints!.array as! [RichTextEntry]
  }
  public var typedProblems: [RichTextEntry] {
    self.problems!.array as! [RichTextEntry]
  }

  public var typedLearnings: [RichTextEntry] {
    self.learnings!.array as! [RichTextEntry]
  }

  public var typedNextSteps: [RichTextEntry] {
    self.nextSteps!.array as! [RichTextEntry]
  }

  public convenience init(
    context: NSManagedObjectContext,
    startedAt: Date,
    categories: [Category],
    focusTopic: String,
    timerRunoutDuration: TimeInterval,
    running: Bool = false,
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

    Self.defaultTimerRunoutDuration = timerRunoutDuration
  }

  public func play() {
    self.running = true
  }

  public func pause() {
    self.running = false
    self.pauseCount += 1
  }

  public func tick(now: Date = .now) {
    self.runningDurationInSeconds += 1

    if self.runningDurationInSeconds >= self.timerRunoutDurationInSeconds {
      complete(now: now)
    }
  }

  public func complete(now: Date = .now) {
    self.running = false
    self.endedAt = now
  }
}

#if DEBUG
  extension FocusTimer {
    public static var mocked: FocusTimer {
      .init(
        context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType),
        startedAt: .now,
        categories: [],
        focusTopic: "Swift Programming",
        timerRunoutDuration: .minutes(25)
      )
    }
  }
#endif
