import ComposableArchitecture
import Foundation
import Utility

struct HistoryFeatureActionHandler {
   typealias State = HistoryFeatureState
   typealias Action = HistoryFeatureAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   // add Action handlers here
}
