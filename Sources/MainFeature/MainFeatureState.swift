import ComposableArchitecture
import Foundation
import HandySwift
import SFSafeSymbols
import Utility

public struct MainFeatureState: Equatable {
   public enum SidebarEntry: String, CaseIterable, Displayable, Identifiable {
      case history
      case statistics

      public var displayName: String {
         switch self {
         case .history:
            #warning("🧑‍💻 localize this")
            return "History"

         case .statistics:
            #warning("🧑‍💻 localize this")
            return "Statistics"
         }
      }

      var symbol: SFSymbol {
         switch self {
         case .history:
            return .calendarBadgeClock

         case .statistics:
            return .chartBarXaxis
         }
      }

      public var id: String { self.rawValue }
   }

   @BindableState
   var selectedSidebarEntry: SidebarEntry = .history

   public init() {}
}

#if DEBUG
   extension MainFeatureState: Withable {}
#endif
