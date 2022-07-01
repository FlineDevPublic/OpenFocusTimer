import ComposableArchitecture
import Model
import Resources
import SFSafeSymbols
import SettingsEditCategoryGroup
import SwiftUI
import Utility

public struct SettingsCategoryGroupsView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            List {
               if viewStore.categoryGroups.isEmpty {
                  Text(Loc.SettingsCategoryGroups.EmptyState.Message.string)
               } else {
                  ForEach(viewStore.categoryGroups) { categoryGroup in
                     #if os(macOS)
                        self.categoryGroupEntryView(categoryGroup: categoryGroup)
                           .frame(height: 32)
                     #else
                        Button {
                           viewStore.send(.editCategoryGroupButtonPressed(categoryGroup: categoryGroup))
                        } label: {
                           self.categoryGroupEntryViewIOS(categoryGroup: categoryGroup)
                              .padding(.horizontal, 10)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                           Button {
                              viewStore.send(.deleteCategoryGroupButtonPressed(categoryGroup: categoryGroup))
                           } label: {
                              Image(systemSymbol: .trash)
                           }
                           .tint(.red)
                        }
                        .confirmationDialog(
                           Loc.Global.Label.ConfirmActionTitle.string,
                           isPresented: viewStore.binding(\.$showDeleteConfirmDialog)
                        ) {
                           Button(role: .destructive) {
                              viewStore.send(.deleteCategoryGroupConfirmed)
                           } label: {
                              Text(Loc.Global.Action.Delete.string)
                           }
                        } message: {
                           Text(Loc.SettingsCategoryGroups.DeleteConfirmDialog.Message.string)
                        }
                        .listRowSeparator(.hidden)
                        .frame(height: 44)
                     #endif
                  }
                  .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
               }
            }
            .listStyle(.plain)
            .frame(height: 110)

            Spacer()

            Button(Loc.SettingsCategoryGroups.CreateNewGroupButton.Title.string) {
               viewStore.send(.createNewCategoryGroupButtonPressed)
            }
         }
         .sheet(
            isPresented: viewStore.binding(
               get: { $0.editCategoryGroupState != nil },
               send: SettingsCategoryGroupsAction.setEditCategoryGroup(isPresented:)
            )
         ) {
            IfLetStore(
               self.store.scope(
                  state: \.editCategoryGroupState,
                  action: SettingsCategoryGroupsAction.editCategoryGroup(action:)
               ),
               then: SettingsEditCategoryGroupView.init(store:)
            )
         }
      }
   }

   let store: Store<SettingsCategoryGroupsState, SettingsCategoryGroupsAction>

   public init(store: Store<SettingsCategoryGroupsState, SettingsCategoryGroupsAction>) {
      self.store = store
   }

   func categoryGroupEntryView(categoryGroup: Model.CategoryGroup) -> some View {
      WithViewStore(self.store) { viewStore in
         HStack(alignment: .center, spacing: 10) {
            Text(categoryGroup.name ?? "")
               .font(.headline)
               .foregroundColor(.primary)

            Spacer()

            #if os(macOS)
               Button {
                  viewStore.send(.editCategoryGroupButtonPressed(categoryGroup: categoryGroup))
               } label: {
                  Image(systemSymbol: .pencil)
               }

               Button {
                  viewStore.send(.deleteCategoryGroupButtonPressed(categoryGroup: categoryGroup))
               } label: {
                  Image(systemSymbol: .trash)
               }
               .foregroundColor(.red)
               .confirmationDialog(Loc.Global.Label.ConfirmActionTitle.string, isPresented: viewStore.binding(\.$showDeleteConfirmDialog)) {
                  Button(Loc.Global.Action.Delete.string) {
                     viewStore.send(.deleteCategoryGroupConfirmed)
                  }
               } message: {
                  Text(Loc.SettingsCategoryGroups.DeleteConfirmDialog.Message.string)
               }
            #else
               Image(systemSymbol: .squareAndPencil)
                  .foregroundColor(.secondary)
                  .accessibilityHidden(true)
            #endif
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .tag(categoryGroup)
         .frame(height: 32)
      }
   }

   #if !os(macOS)
      func categoryGroupEntryViewIOS(categoryGroup: Model.CategoryGroup) -> some View {
         WithViewStore(self.store) { viewStore in
            Button {
               viewStore.send(.editCategoryGroupButtonPressed(categoryGroup: categoryGroup))
            } label: {
               self.categoryGroupEntryView(categoryGroup: categoryGroup)
                  .padding(.horizontal, 10)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
               Button {
                  viewStore.send(.deleteCategoryGroupButtonPressed(categoryGroup: categoryGroup))
               } label: {
                  Image(systemSymbol: .trash)
               }
               .tint(.red)
            }
            .confirmationDialog(Loc.Global.Label.ConfirmActionTitle.string, isPresented: viewStore.binding(\.$showDeleteConfirmDialog)) {
               Button(role: .destructive) {
                  viewStore.send(.deleteCategoryGroupConfirmed)
               } label: {
                  Text(Loc.Global.Action.Delete.string)
               }
            } message: {
               Text(Loc.SettingsCategories.DeleteConfirmDialog.Message.string)
            }
            .listRowSeparator(.hidden)
            .frame(height: 44)
         }
      }
   #endif
}

#if DEBUG
   struct SettingsCategoryGroupsView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(context: .mocked),
         reducer: settingsCategoryGroupsReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsCategoryGroupsView(store: self.store)
            .previewVariants()
            .padding()
      }
   }
#endif
