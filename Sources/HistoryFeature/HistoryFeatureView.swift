import ComposableArchitecture
import Model
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct HistoryFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         #warning("🧑‍💻 not yet completed")
         List(viewStore.focusTimers, id: \.objectID) { focusTimer in
            Text(focusTimer.startedAt?.formatted() ?? "Start date missing")
         }
      }
   }

   let store: Store<HistoryFeatureState, HistoryFeatureAction>

   public init(store: Store<HistoryFeatureState, HistoryFeatureAction>) {
      self.store = store
   }
}

#if DEBUG
   struct HistoryFeatureView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init().with { state in
            state.focusTimers = [.mocked, .mocked, .mocked]
         },
         reducer: historyFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         HistoryFeatureView(store: self.store).previewVariants()
      }
   }
#endif
