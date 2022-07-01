import ComposableArchitecture
import SwiftUI
import Utility

#warning("🧑‍💻 consider that on iOS there might just be one window, change the naming here")

public struct MainFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         NavigationSplitView {
            self.sidebarView()
         } detail: {
            self.contentView()
         }
      }
   }

   let store: Store<MainFeatureState, MainFeatureAction>

   public init(
      store: Store<MainFeatureState, MainFeatureAction>
   ) {
      self.store = store
   }

   private func sidebarView() -> some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            ForEach(MainFeatureState.SidebarEntry.allCases) { sidebarEntry in
               Button {
                  viewStore.send(.sidebarEntryPressed(sidebarEntry: sidebarEntry))
               } label: {
                  Label(sidebarEntry.displayName, systemSymbol: sidebarEntry.symbol)
                     .padding()
                     .frame(maxWidth: .infinity, alignment: .leading)
               }
            }
         }
         .padding()
         .font(.title2)
      }
   }

   private func contentView() -> some View {
      WithViewStore(self.store) { viewStore in
         #warning("🧑‍💻 make sure selecting a sidebar entry also causes navigation on iOS")
         switch viewStore.selectedSidebarEntry {
         case .history:
            Text("TODO: History View")

         case .statistics:
            Text("TODO: Statistic View")
         }
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
