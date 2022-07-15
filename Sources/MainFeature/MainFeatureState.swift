import ComposableArchitecture
import Foundation
import HandySwift
import Resources
import SFSafeSymbols
import UIKit
import Utility

public struct MainFeatureState: Equatable {
   public enum SidebarEntry: String, CaseIterable, Displayable, Identifiable {
      case history
      case statistics

      public var displayName: String {
         switch self {
         case .history:
            return Loc.Main.SidebarEntry.History.string

         case .statistics:
            return Loc.Main.SidebarEntry.Statistics.string
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
   var selectedSidebarEntry: SidebarEntry?

   public init() {
      if UIDevice.current.userInterfaceIdiom != .phone {
         self.selectedSidebarEntry = .history
      }
   }
}

#if DEBUG
   extension MainFeatureState: Withable {}
#endif
