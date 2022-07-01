import ComposableArchitecture
import HandySwiftUI
import Model
import Resources
import SFSafeSymbols
import SettingsEditCategory
import SwiftUI
import Utility

public struct SettingsCategoriesView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Text(Loc.SettingsCategories.GroupSelector.Label.locStringKey)
               .frame(maxWidth: .infinity, alignment: .leading)

            Picker(selection: viewStore.binding(\.$selectedGroup)) {
               ForEach(viewStore.categoryGroups) { group in
                  Text(group.name ?? "")
                     .tabItem { Text(group.name!) }
                     .tag(group)
               }
            } label: {
               EmptyView()
            }
            .pickerStyle(.segmented)

            List {
               if let selectedGroupCategories = viewStore.categoriesByGroup[viewStore.state.selectedGroup] {
                  if selectedGroupCategories.isEmpty {
                     Text(Loc.SettingsCategories.CategoriesEmptyState.Message.locStringKey)
                  } else {
                     ForEach(selectedGroupCategories) { category in
                        #if os(macOS)
                           self.categoryEntryView(category: category)
                        #else
                           self.categoryEntryViewIOS(category: category)
                        #endif
                     }
                     .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                  }
               }
            }
            .listStyle(.plain)
            .frame(height: 244)

            Spacer()

            Button(Loc.SettingsCategories.CreateNewCategoryButton.Title.locStringKey) {
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

   func categoryEntryView(category: Model.Category) -> some View {
      WithViewStore(self.store) { viewStore in
         HStack(alignment: .center, spacing: 10) {
            RoundedRectangle(cornerRadius: 5)
               .foregroundColor(category.color)
               .aspectRatio(1, contentMode: .fit)
               .frame(width: 17, height: 17)

            Group {
               category.iconImage
                  .frame(width: 26)
                  .aspectRatio(contentMode: .fit)

               Text(category.name ?? "")
            }
            .font(.headline)

            Spacer()

            #if os(macOS)
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
               .confirmationDialog(Loc.Global.Label.ConfirmActionTitle.locStringKey, isPresented: viewStore.binding(\.$showDeleteConfirmDialog)) {
                  Button(Loc.Global.Action.Delete.locStringKey) {
                     viewStore.send(.deleteCategoryConfirmed)
                  }
               } message: {
                  Text(Loc.SettingsCategories.DeleteConfirmDialog.Message.locStringKey)
               }
            #else
               Image(systemSymbol: .squareAndPencil)
                  .foregroundColor(.secondary)
                  .accessibilityHidden(true)
            #endif
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .tag(category)
         .frame(height: 32)
      }
   }

   #if !os(macOS)
      func categoryEntryViewIOS(category: Model.Category) -> some View {
         WithViewStore(self.store) { viewStore in
            Button {
               viewStore.send(.editCategoryButtonPressed(category: category))
            } label: {
               self.categoryEntryView(category: category)
                  .padding(.horizontal, 10)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
               Button {
                  viewStore.send(.deleteCategoryButtonPressed(category: category))
               } label: {
                  Image(systemSymbol: .trash)
               }
               .tint(.red)
            }
            .confirmationDialog(Loc.Global.Label.ConfirmActionTitle.locStringKey, isPresented: viewStore.binding(\.$showDeleteConfirmDialog)) {
               Button(role: .destructive) {
                  viewStore.send(.deleteCategoryConfirmed)
               } label: {
                  Text(Loc.Global.Action.Delete.locStringKey)
               }
            } message: {
               Text(Loc.SettingsCategories.DeleteConfirmDialog.Message.locStringKey)
            }
            .listRowSeparator(.hidden)
            .frame(height: 44)
         }
      }
   #endif
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
