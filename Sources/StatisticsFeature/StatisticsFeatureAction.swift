import ComposableArchitecture
import Foundation

public enum StatisticsFeatureAction: Equatable, BindableAction {
   // add Action cases here

   case binding(BindingAction<StatisticsFeatureState>)
}
