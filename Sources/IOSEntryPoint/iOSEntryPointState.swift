import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import MainFeature
import Model
import Settings
import TimerFeature

public struct IOSEntryPointState: Equatable {
   enum TabItem: String, CaseIterable, Hashable, Identifiable {
      case main
      case timer
      case settings

      var id: String { self.rawValue }
   }

   @BindableState
   var selectedTab: TabItem = .timer

   var timerState: TimerState
   var mainFeatureState: MainFeatureState
   var settingsState: SettingsState

   public init(context: NSManagedObjectContext, currentFocusTimer: FocusTimer) {
      self.timerState = .init(currentFocusTimer: currentFocusTimer)
      self.mainFeatureState = .init()
      self.settingsState = .init(context: context)
   }
}

#if DEBUG
   extension IOSEntryPointState: Withable {}
#endif
