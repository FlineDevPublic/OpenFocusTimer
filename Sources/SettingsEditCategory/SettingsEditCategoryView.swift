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
            TextField(
               L10n.SettingsCategories.EditCategory.nameLabel,
               text: viewStore.binding(\.$name),
               prompt: Text(L10n.SettingsCategories.EditCategory.namePlaceholder)
            )

            ColorPicker(
               L10n.SettingsCategories.EditCategory.colorLabel,
               selection: viewStore.binding(\.$color)
            )

            Picker(
               L10n.SettingsCategories.EditCategory.iconLabel,
               selection: viewStore.binding(\.$icon)
            ) {
               ForEach(SFSymbol.selection) { symbol in
                  Label(symbol.rawValue, systemSymbol: symbol).tag(symbol)
               }
            }

            HStack {
               Button(L10n.Global.Action.cancel) {
                  viewStore.send(.cancelButtonPressed)
               }

               Button(L10n.Global.Action.save) {
                  viewStore.send(.saveButtonPressed)
               }
               .disabled(viewStore.name.isBlank)
            }
         }
         .padding()
         .macOSOnly { view in
            view.frame(minWidth: 400, maxHeight: 200)
         }
      }
   }

   let store: Store<SettingsEditCategoryState, SettingsEditCategoryAction>

   public init(store: Store<SettingsEditCategoryState, SettingsEditCategoryAction>) {
      self.store = store
   }
}

extension SFSymbol {
   #warning("restrict this to a selection of symbols for performance reasons")
   public static var selection: [SFSymbol] {
      self.allSymbols.sorted { lhs, rhs in
         lhs.rawValue < rhs.rawValue
      }
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
