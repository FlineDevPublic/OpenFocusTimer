import ComposableArchitecture
import Foundation
import HandySwift
import Model

public struct HistoryFeatureState: Equatable {
   var focusTimers: [FocusTimer]

   public init() {
      #warning("🧑‍💻 load initial data from database or do it on appear")
      self.focusTimers = []
   }
}

#if DEBUG
   extension HistoryFeatureState: Withable {}
#endif
