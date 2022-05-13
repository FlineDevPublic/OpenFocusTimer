import ComposableArchitecture
import Foundation
import MainFeature
import Settings
import TimerFeature

public enum IOSEntryPointAction: Equatable, BindableAction {
   case timer(action: TimerAction)
   case mainFeature(action: MainFeatureAction)
   case settings(action: SettingsAction)

   case binding(BindingAction<IOSEntryPointState>)
}
