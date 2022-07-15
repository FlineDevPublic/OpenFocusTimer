import ComposableArchitecture
import Foundation

public enum HistoryFeatureAction: Equatable, BindableAction {
   // add Action cases here

   case binding(BindingAction<HistoryFeatureState>)
}
