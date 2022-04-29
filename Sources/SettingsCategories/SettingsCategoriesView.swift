import ComposableArchitecture
import HandySwiftUI
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct SettingsCategoriesView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Text(L10n.SettingsCategories.GroupSelector.label)
               .frame(maxWidth: .infinity, alignment: .leading)

            Picker(selection: viewStore.binding(\.$selectedGroup)) {
               ForEach(viewStore.categoryGroups) { group in
                  Text(group.name!)
                     .tabItem { Text(group.name!) }
                     .tag(group)
               }
            } label: {
               EmptyView()
            }
            .pickerStyle(.segmented)

            VStack(alignment: .leading, spacing: 20) {
               ForEach(viewStore.categoriesByGroup[viewStore.state.selectedGroup]!) { category in
                  HStack(alignment: .top, spacing: 20) {
                     #warning("turn this text into a text field")
                     TextField(
                        text: viewStore.binding(
                           get: { _ in category.name! },
                           send: { SettingsCategoriesAction.categoryNameChanged(category: category, name: $0) }
                        )
                     ) {
                        EmptyView()
                     }
                     .textFieldStyle(.roundedBorder)
                     .font(.headline)

                     Spacer()

                     Button {
                        viewStore.send(.deleteCategoryButtonPressed(category: category))
                     } label: {
                        Image(systemSymbol: .trash)
                     }
                     .foregroundColor(.red)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .tag(category)
               }
            }
            .padding(.vertical)

            Spacer()

            Button(L10n.SettingsCategories.CreateNewCategoryButton.title) {
               viewStore.send(.createNewCategoryButtonPressed)
            }
         }
      }
   }

   let store: Store<SettingsCategoriesState, SettingsCategoriesAction>

   public init(store: Store<SettingsCategoriesState, SettingsCategoriesAction>) {
      self.store = store
   }
}

#if DEBUG
   struct SettingsCategoriesView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(context: .mocked),
         reducer: settingsCategoriesReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsCategoriesView(store: self.store)
            .previewVariants()
            .padding()
      }
   }
#endif
