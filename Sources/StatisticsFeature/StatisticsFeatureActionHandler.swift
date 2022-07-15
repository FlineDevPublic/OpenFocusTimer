import ComposableArchitecture
import Foundation
import Utility

struct StatisticsFeatureActionHandler {
   typealias State = StatisticsFeatureState
   typealias Action = StatisticsFeatureAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   // add Action handlers here
}
