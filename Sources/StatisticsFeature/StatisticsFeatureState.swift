import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import Model

public struct StatisticsFeatureState: Equatable {
   struct CategoryStat: Equatable, Identifiable {
      let category: Model.Category
      let totalTimeTracked: TimeInterval

      var id: String {
         self.category.id
      }
   }

   var categoryStatsByGroup: [CategoryGroup: [CategoryStat]]

   public init(context: NSManagedObjectContext) {
      do {
         let categoryGroups = try context.fetch(CategoryGroup.fetchRequest())
         self.categoryStatsByGroup = [:]

         for group in categoryGroups {
            let categoriesInGroup = group.typedCategories.sorted()
            var categoryStats: [CategoryStat] = []

            for category in categoriesInGroup {
               let focusTimersOfCategory = category.typedFocusTimers.sorted()
               let totalTimeTracked: TimeInterval = focusTimersOfCategory.reduce(into: 0) { $0 += $1.runningDuration }
               categoryStats.append(.init(category: category, totalTimeTracked: totalTimeTracked))
            }

            self.categoryStatsByGroup[group] = categoryStats
         }
      } catch {
         #warning("🧑‍💻 when app is ready for analytics / crash reporting")
         fatalError("error occurred while reading category (groups): \(error.localizedDescription)")
      }
   }
}

#if DEBUG
   extension StatisticsFeatureState: Withable {}

   extension Model.Category: Comparable {
      public static func < (left: Model.Category, right: Model.Category) -> Bool {
         (left.name ?? "") < (right.name ?? "")
      }
   }

   extension FocusTimer: Comparable {
      public static func < (left: FocusTimer, right: FocusTimer) -> Bool {
         (left.startedAt ?? Date.now) < (right.startedAt ?? Date.now)
      }
   }
#endif
