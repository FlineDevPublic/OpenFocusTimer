import ComposableArchitecture
import SwiftUI
import Utility

#warning("consider that on iOS there might just be one window, change the naming here")

public struct MainFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         NavigationView {
            self.sidebarView()
            self.contentView()
         }
         .frame(width: 600, height: 400)
      }
   }

   let store: Store<MainFeatureState, MainFeatureAction>

   public init(
      store: Store<MainFeatureState, MainFeatureAction>
   ) {
      self.store = store
   }

   private func sidebarView() -> some View {
      VStack {
         Spacer()
         HStack {
            Spacer()
            Text("Sidebar")
            Spacer()
         }
         Spacer()
      }
      .frame(width: 180)
   }

   private func contentView() -> some View {
      VStack {
         Spacer()
         HStack {
            Spacer()
            Text("Main Content")
            Spacer()
         }
         Spacer()
      }
   }
}

#if DEBUG
   struct MainFeatureView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .init(),
         reducer: mainFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         MainFeatureView(store: self.store)
            .previewVariants()
      }
   }
#endif
