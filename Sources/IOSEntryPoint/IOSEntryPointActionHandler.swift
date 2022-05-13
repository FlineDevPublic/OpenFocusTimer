import ComposableArchitecture
import Foundation
import Utility

struct IOSEntryPointActionHandler {
   typealias State = IOSEntryPointState
   typealias Action = IOSEntryPointAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   // add Action handlers here
}
