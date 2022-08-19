import ComposableArchitecture
import Foundation

public enum HistoryFeatureAction: Equatable, BindableAction {
   case onAppear

   case binding(BindingAction<HistoryFeatureState>)
}
