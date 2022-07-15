import ComposableArchitecture
import Resources
import SwiftUI
import Utility

#warning("🧑‍💻 consider that on iOS there might just be one window, change the naming here")

public struct MainFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         NavigationSplitView {
            List(MainFeatureState.SidebarEntry.allCases, selection: viewStore.binding(\.$selectedSidebarEntry)) { sidebarEntry in
               HStack {
                  Label(sidebarEntry.displayName, systemSymbol: sidebarEntry.symbol)

                  Spacer()

                  if UIDevice.current.userInterfaceIdiom == .phone {
                     Image(systemSymbol: .chevronRight).foregroundColor(.secondary.opacity(0.5))
                  }
               }
               .tag(sidebarEntry)
            }
         } detail: {
            VStack {
               self.contentView()
            }
         }
      }
   }

   let store: Store<MainFeatureState, MainFeatureAction>

   public init(
      store: Store<MainFeatureState, MainFeatureAction>
   ) {
      self.store = store
   }

   private func contentView() -> some View {
      WithViewStore(self.store) { viewStore in
         #warning("🧑‍💻 make sure selecting a sidebar entry also causes navigation on iOS")
         switch viewStore.selectedSidebarEntry {
         case .history:
            Text("TODO: History View")

         case .statistics:
            Text("TODO: Statistic View")

         case .none:
            Text(Loc.Main.Detail.EmptyState.string)
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
