import CoreData
import Foundation
import Resources

public final class DatabaseSeeder {
   public static let shared = DatabaseSeeder()

   public func seed(context: NSManagedObjectContext) throws {
      #warning("🧑‍💻 instead of checking of empty category groups, consider checking if first app start")
      let categoriesAreEmpty = try context.count(for: CategoryGroup.fetchRequest()) == 0

      if categoriesAreEmpty {
         // create category groups
         let projectGroup = CategoryGroup(context: context, name: L10n.DatabaseSeeder.ProjectGroup.name)
         let taskTypeGroup = CategoryGroup(context: context, name: L10n.DatabaseSeeder.TaskTypeGroup.name)

         // create projects
         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.MainProjectCategory.name + " 1",
            color: .green,
            icon: .hourglass,
            group: projectGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.MainProjectCategory.name + " 2",
            color: .orange,
            icon: .personWave2,
            group: projectGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.SideProjectCategory.name + " 1",
            color: .yellow,
            icon: .appsIphone,
            group: projectGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.SideProjectCategory.name + " 2",
            color: .red,
            icon: .chevronLeftForwardslashChevronRight,
            group: projectGroup
         )

         // create task types
         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.TaskTypeDesign.name,
            color: .pink,
            icon: .sparkles,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.TaskTypeProgramming.name,
            color: .blue,
            icon: .hammer,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.TaskTypeCodeReview.name,
            color: .green,
            icon: .checkmarkSeal,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.TaskTypeResearch.name,
            color: .yellow,
            icon: .rectangleAndTextMagnifyingglass,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: L10n.DatabaseSeeder.TaskTypePaperwork.name,
            color: .gray,
            icon: .doc,
            group: taskTypeGroup
         )

         try context.save()
      }
   }
}
