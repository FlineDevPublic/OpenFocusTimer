import ComposableArchitecture
import SFSafeSymbols
import SettingsCategories
import SwiftUI
import Utility

public struct SettingsView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         TabView(selection: viewStore.binding(\.$selectedTab)) {
            VStack {
               Spacer()
               HStack {
                  Spacer()
                  Text("General")
                  Spacer()
               }
               Spacer()
            }
            .tabItem {
               VStack {
                  Image(systemSymbol: SettingsState.Tab.general.systemSymbol)
                  Text(SettingsState.Tab.general.displayName)
               }
               .frame(width: 100, height: 100)
            }
            .tag(SettingsState.Tab.general)

            SettingsCategoriesView(
               store: self.store.scope(
                  state: \.settingsCategoriesState,
                  action: SettingsAction.settingsCategories(action:)
               )
            )
            .tabItem {
               VStack {
                  Image(systemSymbol: SettingsState.Tab.categories.systemSymbol)
                  Text(SettingsState.Tab.categories.displayName)
               }
               .frame(width: 100, height: 100)
            }
            .tag(SettingsState.Tab.categories)
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
}

#if DEBUG
   struct SettingsView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .init(context: .mocked),
         reducer: settingsReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsView(store: self.store)
            .previewVariants()
      }
   }
#endif
