import ComposableArchitecture
import HistoryFeature
import Resources
import StatisticsFeature
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
               switch viewStore.selectedSidebarEntry {
               case .history:
                  HistoryFeatureView(
                     store: self.store.scope(
                        state: \.historyFeatureState,
                        action: MainFeatureAction.historyFeature(action:)
                     )
                  )

               case .statistics:
                  StatisticsFeatureView(
                     store: self.store.scope(
                        state: \.statisticsFeatureState,
                        action: MainFeatureAction.statisticsFeature(action:)
                     )
                  )

               case .none:
                  Text(Loc.Main.Detail.EmptyState.string)
               }
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
}

#if DEBUG
   struct MainFeatureView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .init(context: .mocked),
         reducer: mainFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         MainFeatureView(store: self.store)
            .previewVariants()
      }
   }
#endif
