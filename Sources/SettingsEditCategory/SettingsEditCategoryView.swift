import ComposableArchitecture
import HandySwiftUI
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct SettingsEditCategoryView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         Form {
            Section {
               TextField(
                  Loc.SettingsCategories.EditCategory.NameLabel.locStringKey,
                  text: viewStore.binding(\.$name),
                  prompt: Text(Loc.SettingsCategories.EditCategory.NamePlaceholder.locStringKey)
               )

               ColorPicker(
                  Loc.SettingsCategories.EditCategory.ColorLabel.locStringKey,
                  selection: viewStore.binding(\.$color)
               )

               Picker(
                  Loc.SettingsCategories.EditCategory.IconLabel.locStringKey,
                  selection: viewStore.binding(\.$icon)
               ) {
                  ForEach(SFSymbol.selection) { symbol in
                     HStack {
                        Image(systemSymbol: symbol)
                        Text(symbol.rawValue)
                     }
                     .tag(symbol)
                  }
               }
            }

            Section {
               #if os(macOS)
                  HStack {
                     Button(Loc.Global.Action.Cancel.locStringKey) {
                        viewStore.send(.cancelButtonPressed)
                     }

                     Button(Loc.Global.Action.Save.locStringKey) {
                        viewStore.send(.saveButtonPressed)
                     }
                     .disabled(viewStore.name.isBlank)
                  }
               #else
                  Button(Loc.Global.Action.Cancel.locStringKey) {
                     viewStore.send(.cancelButtonPressed)
                  }

                  Button(Loc.Global.Action.Save.locStringKey) {
                     viewStore.send(.saveButtonPressed)
                  }
                  .disabled(viewStore.name.isBlank)
               #endif
            }

            #if os(iOS)
               if let category = viewStore.existingCategory {
                  Section {
                     Button(role: .destructive) {
                        viewStore.send(.deleteButtonPressed)
                     } label: {
                        Text(Loc.Global.Action.Delete.locStringKey)
                     }
                     .confirmationDialog(
                        Loc.Global.Label.ConfirmActionTitle.locStringKey,
                        isPresented: viewStore.binding(\.$showDeleteConfirmDialog)
                     ) {
                        Button(role: .destructive) {
                           viewStore.send(.deleteConfirmed(category: category))
                        } label: {
                           Text(Loc.Global.Action.Delete.locStringKey)
                        }
                     } message: {
                        Text(Loc.SettingsCategories.DeleteConfirmDialog.Message.locStringKey)
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

   let store: Store<SettingsEditCategoryState, SettingsEditCategoryAction>

   public init(store: Store<SettingsEditCategoryState, SettingsEditCategoryAction>) {
      self.store = store
   }
}

extension SFSymbol {
   public static let selection: [SFSymbol] =
      SFSymbol.allSymbols.filter { $0.rawValue.components(separatedBy: ".").count == 1 }.sorted { left, right in
         left.rawValue < right.rawValue
      }
}

extension SFSymbol: Identifiable {
   public var id: String { self.rawValue }
}

#if DEBUG
   struct SettingsEditCategoryView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(group: .mocked, existingCategory: nil),
         reducer: settingsEditCategoryReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsEditCategoryView(store: self.store).previewVariants()
      }
   }
#endif
