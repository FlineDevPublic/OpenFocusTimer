import ComposableArchitecture
import HandySwiftUI
import Resources
import SFSafeSymbols
import SettingsEditCategory
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

            ScrollView {
               VStack(alignment: .leading, spacing: 20) {
                  if viewStore.categoriesByGroup[viewStore.state.selectedGroup]!.isEmpty {
                     Text(L10n.SettingsCategories.CategoriesEmptyState.message)
                  } else {
                     ForEach(viewStore.categoriesByGroup[viewStore.state.selectedGroup]!) { category in
                        HStack(alignment: .top, spacing: 10) {
                           RoundedRectangle(cornerRadius: 5)
                              .foregroundColor(category.color)
                              .aspectRatio(1, contentMode: .fit)

                           Group {
                              category.iconImage
                                 .frame(width: 26)
                                 .aspectRatio(contentMode: .fit)

                              Text(category.name!)
                           }
                           .font(.headline)

                           Spacer()

                           Button {
                              viewStore.send(.editCategoryButtonPressed(category: category))
                           } label: {
                              Image(systemSymbol: .pencil)
                           }

                           Button {
                              viewStore.send(.deleteCategoryButtonPressed(category: category))
                           } label: {
                              Image(systemSymbol: .trash)
                           }
                           .foregroundColor(.red)
                           .confirmationDialog(L10n.Global.Label.confirmActionTitle, isPresented: viewStore.binding(\.$showDeleteConfirmDialog)) {
                              Button(L10n.Global.Action.delete) {
                                 viewStore.send(.deleteCategoryConfirmed)
                              }
                           } message: {
                              Text(L10n.SettingsCategories.DeleteConfirmDialog.message)
                           }
                        }
                        .frame(height: 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .tag(category)
                     }
                  }
               }
               .padding(.vertical)
               .padding(.trailing, 10)
            }

            Spacer()

            Button(L10n.SettingsCategories.CreateNewCategoryButton.title) {
               viewStore.send(.createNewCategoryButtonPressed)
            }
         }
         .sheet(
            isPresented: viewStore.binding(
               get: { $0.editCategoryState != nil },
               send: SettingsCategoriesAction.setEditCategory(isPresented:)
            )
         ) {
            IfLetStore(
               self.store.scope(
                  state: \.editCategoryState,
                  action: SettingsCategoriesAction.editCategory(action:)
               ),
               then: SettingsEditCategoryView.init(store:)
            )
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
