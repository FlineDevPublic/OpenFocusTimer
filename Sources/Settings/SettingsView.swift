import ComposableArchitecture
import SwiftUI
import Utility

public struct SettingsView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         TabView(selection: viewStore.binding(\.$selectedTab)) {
            ForEach(SettingsState.Tab.allCases) { tab in
               self.tabView(tab: tab)
                  .tabItem {
                     VStack {
                        Image(systemSymbol: tab.systemSymbol)
                        Text(tab.displayName)
                     }
                     .frame(width: 100, height: 100)
                  }
                  .tag(tab)
            }
         }
         .frame(width: 500, height: 500)
         .padding()
      }
   }

   let store: Store<SettingsState, SettingsAction>

   public init(
      store: Store<SettingsState, SettingsAction>
   ) {
      self.store = store
   }

   private func tabView(tab: SettingsState.Tab) -> some View {
      VStack {
         Spacer()
         HStack {
            Spacer()
            Text(tab.displayName)
            Spacer()
         }
         Spacer()
      }
   }
}

#if DEBUG
   struct SettingsView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .init(),
         reducer: settingsReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsView(store: self.store)
            .previewVariants()
      }
   }
#endif
