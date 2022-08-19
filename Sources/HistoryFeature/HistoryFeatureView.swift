import ComposableArchitecture
import Model
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct HistoryFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         if viewStore.focusTimers.isEmpty {
            Text(Loc.HistoryFeature.EmptyState.Message.string)
         } else {
            Form {
               ForEach(Array(viewStore.focusTimerPerDay.keys), id: \.self) { dayDate in
                  Section(dayDate.formatted(date: .abbreviated, time: .omitted)) {
                     List(viewStore.focusTimerPerDay[dayDate]!, id: \.objectID) { focusTimer in
                        HistoryRowView(focusTimer: focusTimer)
                     }
                  }
               }
            }
         }
      }
      .navigationTitle(Loc.HistoryFeature.NavigationTitle.string)
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
            state.focusTimers = [.mocked, .mocked, .mocked, .mocked, .mocked]
         },
         reducer: historyFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         NavigationStack {
            HistoryFeatureView(store: self.store)
         }
         .previewVariants()
      }
   }
#endif
