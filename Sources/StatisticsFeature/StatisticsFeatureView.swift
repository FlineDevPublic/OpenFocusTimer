import Charts
import ComposableArchitecture
import Model
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct StatisticsFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         ScrollView {
            ForEach(viewStore.categoryStatsByGroup.keys.sorted()) { group in
               Chart {
                  ForEach(viewStore.categoryStatsByGroup[group]!) { categoryStat in
                     BarMark(
                        x: .value("Category Name", categoryStat.category.name ?? "???"),
                        y: .value("Total Time", categoryStat.totalTimeTracked)
                     )
                  }
               }
               .frame(minHeight: 200)
               .padding()
            }
         }
      }
   }

   let store: Store<StatisticsFeatureState, StatisticsFeatureAction>

   public init(store: Store<StatisticsFeatureState, StatisticsFeatureAction>) {
      self.store = store
   }
}

extension CategoryGroup: Comparable {
   public static func < (left: CategoryGroup, right: CategoryGroup) -> Bool {
      switch (left.name, right.name) {
      case (.some(let leftName), .some(let rightName)):
         return leftName < rightName

      default:
         return false
      }
   }
}

#if DEBUG
   struct StatisticsFeatureView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(context: .mocked),
         reducer: statisticsFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         StatisticsFeatureView(store: self.store).previewVariants()
      }
   }
#endif
