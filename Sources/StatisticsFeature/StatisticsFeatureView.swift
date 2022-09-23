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
               VStack(spacing: 0) {
                  HStack {
                     VStack(alignment: .leading, spacing: 5) {
                        Text(Loc.StatisticsFeature.WorkTimeChart.Title(totalHours: viewStore.totalTimeTracked).string)
                           .font(.title2)

                        Text(Loc.StatisticsFeature.WorkTimeChart.Subtitle(groupName: group.name ?? "???").string)
                           .font(.headline)
                           .foregroundColor(.secondary)
                     }

                     Spacer()
                  }
                  .padding([.top, .leading, .trailing])

                  #warning("🧑‍💻 fix contrast of legend – currently not high enough")
                  Chart {
                     ForEach(viewStore.categoryStatsByGroup[group]!) { categoryStat in
                        BarMark(
                           x: .value("Category", categoryStat.category.name ?? "???"),
                           y: .value("Total Time", categoryStat.totalTimeTracked.hours)
                        )
                     }
                  }
                  .chartXAxis {
                     AxisMarks(values: .automatic) { value in
                        AxisValueLabel { // construct Text here
                           if let categoryName = value.as(String.self) {
                              if let categoryStat = viewStore.categoryStatsByGroup[group]?.first(where: { $0.category.name == categoryName }) {
                                 #warning("🧑‍💻 users can choose colors with bad contrast – find a solution")
                                 categoryStat.category.iconImage
                                    .foregroundColor(categoryStat.category.color)
                                    .font(.title2)
                                    .padding(.top, 10)
                              } else {
                                 Text(categoryName)
                              }
                           } else {
                              Text("???")
                           }
                        }
                     }
                  }
                  .frame(minHeight: 200)
                  .padding()
               }
               .background(.secondary.opacity(0.1))
               .cornerRadius(20)
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
