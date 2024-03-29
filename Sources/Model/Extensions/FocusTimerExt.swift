import CoreData
import Foundation
import HandySwift
import OrderedCollections

extension FocusTimer {
   #if DEBUG
      /// Default focus timer length.
      public static var defaultTimerRunoutDuration: TimeInterval = .seconds(25)
   #else
      /// Default focus timer length.
      public static var defaultTimerRunoutDuration: TimeInterval = .minutes(25)
   #endif

   public var hasNotStarted: Bool {
      self.runningDurationInSeconds == 0
   }

   #warning("🧑‍💻 consider calculating this based on current time for currently running timers")
   public var runningDuration: TimeInterval {
      .seconds(Double(runningDurationInSeconds))
   }

   public var currentProgress: Double {
      self.runningDuration / self.timerRunoutDuration
   }

   #warning("🧑‍💻 document these properties")
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
      get {
         self.progressPoints?.array as! [RichTextEntry]? ?? []
      }

      set {
         self.progressPoints = NSOrderedSet(array: newValue)
      }
   }

   public var typedProblems: [RichTextEntry] {
      get {
         self.problems?.array as! [RichTextEntry]? ?? []
      }

      set {
         self.problems = NSOrderedSet(array: newValue)
      }
   }

   public var typedLearnings: [RichTextEntry] {
      get {
         self.learnings?.array as! [RichTextEntry]? ?? []
      }

      set {
         self.learnings = NSOrderedSet(array: newValue)
      }
   }

   public var typedNextSteps: [RichTextEntry] {
      get {
         self.nextSteps?.array as! [RichTextEntry]? ?? []
      }

      set {
         self.nextSteps = NSOrderedSet(array: newValue)
      }
   }

   public var typedCategories: Set<Category> {
      get {
         self.categories as! Set<Category>? ?? []
      }

      set {
         self.categories = NSSet(set: newValue)
      }
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

      self.categories = NSSet(array: categories)
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

   public func tick(now: Date) {
      self.runningDurationInSeconds += 1

      if self.runningDurationInSeconds >= self.timerRunoutDurationInSeconds {
         complete(now: now)
      }
   }

   public func complete(now: Date) {
      self.running = false
      self.endedAt = now
   }
}

#if DEBUG
   extension FocusTimer {
      public static var mocked: FocusTimer {
         let mocked = FocusTimer(context: .mocked)
         let group = CategoryGroup(context: .mocked, name: "Projects")
         mocked.categories = [
            Category(context: .mocked, name: "Project A", color: .green, icon: .phone, group: group),
            Category(context: .mocked, name: "Project B", color: .yellow, icon: .photo, group: group),
            Category(context: .mocked, name: "Project C", color: .blue, icon: .car, group: group),
         ]
         mocked.startedAt = Date().addingTimeInterval(.days([-3, -4, -5].randomElement()!))
         mocked.endedAt = mocked.startedAt!.addingTimeInterval(
            .hours([2, 3, 4].randomElement()!)
               + .minutes([15, 50].randomElement()!)
               + .seconds([30, 45, 00].randomElement()!)
         )
         mocked.runningDurationInSeconds = 2 * 60 * 60 + 15 * 60 + 30
         return mocked
      }
   }
#endif
