import ComposableArchitecture
import SwiftUI
import Utility

#warning("consider that on iOS there might just be one window, change the naming here")

public struct MainFeatureView: View {
   let store: Store<MainFeatureState, MainFeatureAction>

   public init(
      store: Store<MainFeatureState, MainFeatureAction>
   ) {
      self.store = store
   }

   public var body: some View {
      WithViewStore(self.store) { viewStore in
         Text("Main Feature")
      }
   }
}

#if DEBUG
   struct MainWindowView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .init(),
         reducer: mainWindowReducer,
         environment: .mocked
      )

      static var previews: some View {
         MainFeatureView(store: self.store)
            .previewVariants()
      }
   }
#endif
