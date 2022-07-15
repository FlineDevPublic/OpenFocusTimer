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
                  Loc.SettingsCategoryGroups.EditCategoryGroup.NameLabel.string,
                  text: viewStore.binding(\.$name),
                  prompt: Text(Loc.SettingsCategoryGroups.EditCategoryGroup.Placeholder.string)
               )
            }

            Section {
               #if os(macOS)
                  HStack {
                     Button(Loc.Global.Action.Cancel.string) {
                        viewStore.send(.cancelButtonPressed)
                     }

                     Button(Loc.Global.Action.Save.string) {
                        viewStore.send(.saveButtonPressed)
                     }
                     .disabled(viewStore.name.isBlank)
                  }
               #else
                  Button(Loc.Global.Action.Cancel.string) {
                     viewStore.send(.cancelButtonPressed)
                  }

                  Button(Loc.Global.Action.Save.string) {
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
                        Text(Loc.Global.Action.Delete.string)
                     }
                     .confirmationDialog(
                        Loc.Global.Label.ConfirmActionTitle.string,
                        isPresented: viewStore.binding(\.$showDeleteConfirmDialog)
                     ) {
                        Button(role: .destructive) {
                           viewStore.send(.deleteConfirmed(categoryGroup: categoryGroup))
                        } label: {
                           Text(Loc.Global.Action.Delete.string)
                        }
                     } message: {
                        Text(Loc.SettingsCategoryGroups.DeleteConfirmDialog.Message.string)
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
