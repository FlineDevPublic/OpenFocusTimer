import ComposableArchitecture
import Foundation
import Model
import Utility

struct HistoryFeatureActionHandler {
   typealias State = HistoryFeatureState
   typealias Action = HistoryFeatureAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func onAppear(state: inout State) -> Next {
      #warning("🧑‍💻 paginate the fetches")
      do {
         state.focusTimers = try env.managedObjectContext.fetch(FocusTimer.fetchRequest())
      } catch {
         #warning("🧑‍💻 handle error here")
         print("Something went wrong while fetching focus timers from database: \(error.localizedDescription)")
      }
      return .none
   }
}
