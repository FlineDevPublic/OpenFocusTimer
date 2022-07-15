import ComposableArchitecture
import Foundation
import HistoryFeature
import StatisticsFeature

public enum MainFeatureAction: Equatable, BindableAction {
   case sidebarEntryPressed(sidebarEntry: State.SidebarEntry)

   case historyFeature(action: HistoryFeatureAction)
   case statisticsFeature(action: StatisticsFeatureAction)

   case binding(BindingAction<MainFeatureState>)

   public typealias State = MainFeatureState
}
