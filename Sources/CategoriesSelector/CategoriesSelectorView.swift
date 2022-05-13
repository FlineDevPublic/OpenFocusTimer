import ComposableArchitecture
import Model
import Resources
import SwiftUI
import Utility

public struct CategoriesSelectorView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            #warning("[Dev] fix the pickers not being shown right away")
            List {
               ForEach(viewStore.categoryGroups) { group in
                  #warning("[Dev] pickers don't update the selection value right away (extra eaction neeeded)")
                  #warning("[Dev] force-unwrapping could lead to a crash with an empty group without categories")
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
            #warning("[Dev] make the list have a proper height for all cases (more groups)")

            #warning("[Dev] provide a different style on iOS – this is Mac-optimized")
            HStack {
               Spacer()

               Button(L10n.Global.Action.close) {
                  viewStore.send(.closeButtonPressed)
               }
            }
            .padding()
         }
      }
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
         CategoriesSelectorView(store: self.store)
            .previewVariants()
      }
   }
#endif
