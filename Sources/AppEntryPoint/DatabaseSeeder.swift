import Foundation
import CoreData
import Model

#warning("used only for skipping the creation of categories / groups during development")
public final class DatabaseSeeder {
  public static let shared = DatabaseSeeder()

  func seed(context: NSManagedObjectContext) throws {
    let categoriesAreEmpty = try context.count(for: CategoryGroup.fetchRequest()) == 0

    if categoriesAreEmpty {
      // create category groups
      let projectGroup = CategoryGroup(context: context, name: "Project")
      let taskTypeGroup = CategoryGroup(context: context, name: "Task Type")

      // create projects
      _ = Category(
        context: context,
        name: "Open Focus Timer",
        color: .green,
        icon: .hourglass,
        group: projectGroup
      )

      _ = Category(
        context: context,
        name: "BartyCrouch",
        color: .orange,
        icon: .personWave2,
        group: projectGroup
      )

      _ = Category(
        context: context,
        name: "App Review",
        color: .yellow,
        icon: .appsIphone,
        group: projectGroup
      )

      _ = Category(
        context: context,
        name: "Code Review",
        color: .red,
        icon: .chevronLeftForwardslashChevronRight,
        group: projectGroup
      )

      // create task types
      _ = Category(
        context: context,
        name: "Design",
        color: .gray,
        icon: .sparkles,
        group: taskTypeGroup
      )

      _ = Category(
        context: context,
        name: "Programming",
        color: .blue,
        icon: .hammer,
        group: taskTypeGroup
      )

      _ = Category(
        context: context,
        name: "Review",
        color: .green,
        icon: .checkmarkSeal,
        group: taskTypeGroup
      )

      try context.save()
    }
  }
}
