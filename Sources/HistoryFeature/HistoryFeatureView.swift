import ComposableArchitecture
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct HistoryFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Spacer()
            HStack {
               Spacer()
               Text("HistoryFeature")
               Spacer()
            }
            Spacer()
         }
         .padding()
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
         initialState: .init(),
         reducer: historyFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         HistoryFeatureView(store: self.store).previewVariants()
      }
   }
#endif
