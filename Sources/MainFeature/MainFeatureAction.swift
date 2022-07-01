import ComposableArchitecture
import Foundation

public enum MainFeatureAction: Equatable, BindableAction {
   case sidebarEntryPressed(sidebarEntry: State.SidebarEntry)

   case binding(BindingAction<MainFeatureState>)

   public typealias State = MainFeatureState
}
