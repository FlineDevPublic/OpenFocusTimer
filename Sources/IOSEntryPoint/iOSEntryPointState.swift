import AppEntryPoint
import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import MainFeature
import Settings

public struct IOSEntryPointState: Equatable {
   enum TabItem: String, CaseIterable, Hashable, Identifiable {
      case main
      case timer
      case settings

      var id: String { self.rawValue }
   }

   @BindableState
   var selectedTab: TabItem = .timer

   var appEntryPointState: AppEntryPointState
   var mainFeatureState: MainFeatureState
   var settingsState: SettingsState

   public init(context: NSManagedObjectContext) {
      self.appEntryPointState = .init()
      self.mainFeatureState = .init()
      self.settingsState = .init(context: context)
   }
}

#if DEBUG
   extension IOSEntryPointState: Withable {}
#endif
