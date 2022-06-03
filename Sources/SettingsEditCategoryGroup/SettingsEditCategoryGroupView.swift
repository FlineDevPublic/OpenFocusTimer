import ComposableArchitecture
import HandySwiftUI
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct SettingsEditCategoryGroupView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         Form {
            Section {
               TextField(
                  L10n.SettingsCategoryGroups.EditCategoryGroup.nameLabel,
                  text: viewStore.binding(\.$name),
                  prompt: Text(L10n.SettingsCateogoryGroups.EditCategoryGroup.placeholer)
               )
            }

            Section {
               #if os(macOS)
                  HStack {
                     Button(L10n.Global.Action.cancel) {
                        viewStore.send(.cancelButtonPressed)
                     }

                     Button(L10n.Global.Action.save) {
                        viewStore.send(.saveButtonPressed)
                     }
                     .disabled(viewStore.name.isBlank)
                  }
               #else
                  Button(L10n.Global.Action.cancel) {
                     viewStore.send(.cancelButtonPressed)
                  }

                  Button(L10n.Global.Action.save) {
                     viewStore.send(.saveButtonPressed)
                  }
                  .disabled(viewStore.name.isBlank)
               #endif
            }

            #if os(iOS)
               if let categoryGroup = viewStore.existingCategoryGroup {
                  Section {
                     Button(role: .destructive) {
                        viewStore.send(.deleteButtonPressed)
                     } label: {
                        Text(L10n.Global.Action.delete)
                     }
                     .confirmationDialog(L10n.Global.Label.confirmActionTitle, isPresented: viewStore.binding(\.$showDeleteConfirmDialog)) {
                        Button(role: .destructive) {
                           viewStore.send(.deleteConfirmed(categoryGroup: categoryGroup))
                        } label: {
                           Text(L10n.Global.Action.delete)
                        }
                     } message: {
                        Text(L10n.SettingsCategoryGroups.DeleteConfirmDialog.message)
                     }
                  }
               }
            #endif
         }
         .macOSOnly { view in
            view
               .padding()
               .frame(minWidth: 400, maxHeight: 200)
         }
      }
   }

   let store: Store<SettingsEditCategoryGroupState, SettingsEditCategoryGroupAction>

   public init(store: Store<SettingsEditCategoryGroupState, SettingsEditCategoryGroupAction>) {
      self.store = store
   }
}

#if DEBUG
   struct SettingsEditCategoryGroupView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(existingCategoryGroup: nil),
         reducer: settingsEditCategoryGroupReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsEditCategoryGroupView(store: self.store).previewVariants()
      }
   }
#endif
