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
         let projectGroup = CategoryGroup(context: context, name: Loc.DatabaseSeeder.ProjectGroup.Name.string)
         let taskTypeGroup = CategoryGroup(context: context, name: Loc.DatabaseSeeder.TaskTypeGroup.Name.string)

         // create projects
         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.MainProjectCategory.Name.string + " 1",
            color: .green,
            icon: .hourglass,
            group: projectGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.MainProjectCategory.Name.string + " 2",
            color: .orange,
            icon: .personWave2,
            group: projectGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.SideProjectCategory.Name.string + " 1",
            color: .yellow,
            icon: .appsIphone,
            group: projectGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.SideProjectCategory.Name.string + " 2",
            color: .red,
            icon: .chevronLeftForwardslashChevronRight,
            group: projectGroup
         )

         // create task types
         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.TaskTypeDesign.Name.string,
            color: .pink,
            icon: .sparkles,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.TaskTypeProgramming.Name.string,
            color: .blue,
            icon: .hammer,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.TaskTypeCodeReview.Name.string,
            color: .green,
            icon: .checkmarkSeal,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.TaskTypeResearch.Name.string,
            color: .yellow,
            icon: .rectangleAndTextMagnifyingglass,
            group: taskTypeGroup
         )

         _ = Category(
            context: context,
            name: Loc.DatabaseSeeder.TaskTypePaperwork.Name.string,
            color: .gray,
            icon: .doc,
            group: taskTypeGroup
         )

         try context.save()
      }
   }
}
