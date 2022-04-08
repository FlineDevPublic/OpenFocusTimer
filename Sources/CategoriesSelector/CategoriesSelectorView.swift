import SwiftUI
import ComposableArchitecture
import Utility
import Model

public struct CategoriesSelectorView: View {
  let store: Store<CategoriesSelectorState, CategoriesSelectorAction>

  public init(
    store: Store<CategoriesSelectorState, CategoriesSelectorAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        #warning("fix the pickers not being shown right away")
        List {
          ForEach(viewStore.categoryGroups) { group in
            #warning("pickers don't update the selection value right away (extra eaction neeeded)")
            #warning("force-unwrapping could lead to a crash with an empty group without categories")
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
        #warning("make the list have a proper height for all cases (more groups)")

        #warning("provide a different style on iOS – this is Mac-optimized")
        HStack {
          Spacer()

          Button("Close") {
            viewStore.send(.closeButtonPressed)
          }
        }
        .padding()
      }
    }
    .frame(minWidth: 300)
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
