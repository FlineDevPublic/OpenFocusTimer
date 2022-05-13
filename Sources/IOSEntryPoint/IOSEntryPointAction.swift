import AppEntryPoint
import ComposableArchitecture
import Foundation
import MainFeature
import Settings

public enum IOSEntryPointAction: Equatable, BindableAction {
   case appEntryPoint(action: AppEntryPointAction)
   case mainFeature(action: MainFeatureAction)
   case settings(action: SettingsAction)

   case binding(BindingAction<IOSEntryPointState>)
}
