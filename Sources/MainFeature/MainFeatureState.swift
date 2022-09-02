import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import HistoryFeature
import Resources
import SFSafeSymbols
import StatisticsFeature
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

   var historyFeatureState: HistoryFeatureState
   var statisticsFeatureState: StatisticsFeatureState

   public init(context: NSManagedObjectContext) {
      if UIDevice.current.userInterfaceIdiom != .phone {
         self.selectedSidebarEntry = .history
      }

      self.historyFeatureState = .init()
      self.statisticsFeatureState = .init(context: context)
   }
}

#if DEBUG
   extension MainFeatureState: Withable {}
#endif
