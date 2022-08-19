import ComposableArchitecture
import Foundation
import HandySwift
import Model

public struct HistoryFeatureState: Equatable {
   var focusTimers: [FocusTimer]

   var focusTimerPerDay: [Date: [FocusTimer]] {
      Dictionary(grouping: self.focusTimers) { focusTimer in
         let startDate = focusTimer.startedAt ?? Date()
         return Calendar.current.startOfDay(for: startDate)
      }
   }

   public init() {
      #warning("🧑‍💻 load initial data from database or do it on appear")
      self.focusTimers = []
   }
}

#if DEBUG
   extension HistoryFeatureState: Withable {}
#endif
