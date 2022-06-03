import ComposableArchitecture
import Model
import Resources
import SwiftUI
import Utility

public struct CategoriesSelectorView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            #warning("🧑‍💻 fix the pickers not being shown right away")
            List {
               ForEach(viewStore.categoryGroups) { group in
                  #warning("🧑‍💻 pickers don't update the selection value right away (extra eaction neeeded)")
                  #warning("🧑‍💻 force-unwrapping could lead to a crash with an empty group without categories")
                  Picker(
                     group.name!,
                     selection: viewStore.binding(
                        get: { $0.selectedGroupCategories[group] },
                        send: { CategoriesSelectorAction.categoryGroupSelectionChanged(group: group, category: $0) }
                     )
                  ) {
                     ForEach(viewStore.categoriesByGroup[group] ?? []) { (category: Model.Category) in
                        Text(category.name!)
                           .tag(Model.Category?.some(category))
                     }
                  }
               }
            }
            .frame(minHeight: 42 * Double(viewStore.categoryGroups.count))
            #warning("🧑‍💻 make the list have a proper height for all cases (more groups)")

            #if os(macOS)
               HStack {
                  Spacer()

                  Button(L10n.Global.Action.close) {
                     viewStore.send(.closeButtonPressed)
                  }
               }
               .padding()
            #endif
         }  // swift-format-ignore: RemoveLine
         #if os(iOS)
            .navigationBarItems(
               trailing: Button(L10n.Global.Action.close) {
                  viewStore.send(.closeButtonPressed)
               }
            )
         #endif
      }  // swift-format-ignore: RemoveLine
      #if os(iOS)
         .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(L10n.Timer.EditCategoriesScreen.title)
      #endif
      .frame(minWidth: 300)
   }

   let store: Store<CategoriesSelectorState, CategoriesSelectorAction>

   public init(
      store: Store<CategoriesSelectorState, CategoriesSelectorAction>
   ) {
      self.store = store
   }
}

#if DEBUG
   struct CategoriesSelectorView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .mocked,
         reducer: categoriesSelectorReducer,
         environment: .mocked
      )

      static var previews: some View {
         #if os(macOS)
            CategoriesSelectorView(store: self.store)
               .previewVariants()
         #else
            NavigationView {
               CategoriesSelectorView(store: self.store)
            }
            .previewVariants()
         #endif
      }
   }
#endif
