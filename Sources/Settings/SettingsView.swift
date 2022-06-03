import ComposableArchitecture
import SFSafeSymbols
import SettingsCategories
import SettingsCategoryGroups
import SwiftUI
import Utility

public struct SettingsView: View {
   #if !os(macOS)
      @State
      var generalGroupExpanded = true

      @State
      var categoriesGroupExpanded = true

      @State
      var categoryGroupsGroupExpanded = true
   #endif

   #warning("🧑‍💻 when confirming delete of a category, the confirm dialog reappears")
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         #if os(macOS)
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

               SettingsCategoryGroupsView(
                  store: self.store.scope(
                     state: \.settingsCategoryGroupsState,
                     action: SettingsAction.settingsCategoryGroups(action:)
                  )
               )
               .tabItem {
                  VStack {
                     Image(systemSymbol: SettingsState.Tab.categoryGroups.systemSymbol)
                     Text(SettingsState.Tab.categoryGroups.displayName)
                  }
                  .frame(width: 100, height: 100)
               }
               .tag(SettingsState.Tab.categoryGroups)
            }
            .frame(width: 500, height: 500)
            .padding()
         #else
            ScrollView {
               self.settingsDisclosureGroup(tab: .general, isExpanded: self.$generalGroupExpanded) {
                  VStack {
                     Spacer()
                     HStack {
                        Spacer()
                        Text("General")
                        Spacer()
                     }
                     Spacer()
                  }
               }

               self.settingsDisclosureGroup(tab: .categories, isExpanded: self.$categoriesGroupExpanded) {
                  SettingsCategoriesView(
                     store: self.store.scope(
                        state: \.settingsCategoriesState,
                        action: SettingsAction.settingsCategories(action:)
                     )
                  )
               }

               self.settingsDisclosureGroup(tab: .categoryGroups, isExpanded: self.$categoryGroupsGroupExpanded) {
                  SettingsCategoryGroupsView(
                     store: self.store.scope(
                        state: \.settingsCategoryGroupsState,
                        action: SettingsAction.settingsCategoryGroups(action:)
                     )
                  )
               }
            }
         #endif
      }
   }

   let store: Store<SettingsState, SettingsAction>

   public init(
      store: Store<SettingsState, SettingsAction>
   ) {
      self.store = store
   }

   #if !os(macOS)
      func settingsDisclosureGroup<Content: View>(
         tab: SettingsState.Tab,
         isExpanded: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content
      ) -> some View {
         DisclosureGroup(isExpanded: isExpanded) {
            content().padding(.vertical, 10)
         } label: {
            Label(tab.displayName, systemSymbol: tab.systemSymbol)
         }
         .padding(.horizontal)
         .padding(.vertical, 10)
         .background(
            RoundedRectangle(cornerRadius: 8)
               .strokeBorder()
               .foregroundColor(.accentColor.opacity(0.25))
         )
         .padding(.horizontal, 10)
      }
   #endif
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
