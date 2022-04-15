import CoreData
import Foundation

@objc(FocusTimer)
public class FocusTimer: NSManagedObject {
   @nonobjc
   public class func fetchRequest() -> NSFetchRequest<FocusTimer> {
      NSFetchRequest<FocusTimer>(entityName: "FocusTimer")
   }

   @NSManaged
   public var endedAt: Date?

   @NSManaged
   public var focusTopic: String?

   @NSManaged
   public var pauseCount: Int16

   @NSManaged
   public var running: Bool

   @NSManaged
   public var runningDurationInSeconds: Int32

   @NSManaged
   public var startedAt: Date?

   @NSManaged
   public var timerRunoutDurationInSeconds: Int32

   @NSManaged
   public var categories: NSSet?

   @NSManaged
   public var learnings: NSOrderedSet?

   @NSManaged
   public var nextSteps: NSOrderedSet?

   @NSManaged
   public var problems: NSOrderedSet?

   @NSManaged
   public var progressPoints: NSOrderedSet?
}

// MARK: Generated accessors for categories
extension FocusTimer {
   @objc(addCategoriesObject:)
   @NSManaged
   public func addToCategories(_ value: Category)

   @objc(removeCategoriesObject:)
   @NSManaged
   public func removeFromCategories(_ value: Category)

   @objc(addCategories:)
   @NSManaged
   public func addToCategories(_ values: NSSet)

   @objc(removeCategories:)
   @NSManaged
   public func removeFromCategories(_ values: NSSet)
}

// MARK: Generated accessors for learnings
extension FocusTimer {
   @objc(insertObject:inLearningsAtIndex:)
   @NSManaged
   public func insertIntoLearnings(_ value: RichTextEntry, at idx: Int)

   @objc(removeObjectFromLearningsAtIndex:)
   @NSManaged
   public func removeFromLearnings(at idx: Int)

   @objc(insertLearnings:atIndexes:)
   @NSManaged
   public func insertIntoLearnings(_ values: [RichTextEntry], at indexes: NSIndexSet)

   @objc(removeLearningsAtIndexes:)
   @NSManaged
   public func removeFromLearnings(at indexes: NSIndexSet)

   @objc(replaceObjectInLearningsAtIndex:withObject:)
   @NSManaged
   public func replaceLearnings(at idx: Int, with value: RichTextEntry)

   @objc(replaceLearningsAtIndexes:withLearnings:)
   @NSManaged
   public func replaceLearnings(at indexes: NSIndexSet, with values: [RichTextEntry])

   @objc(addLearningsObject:)
   @NSManaged
   public func addToLearnings(_ value: RichTextEntry)

   @objc(removeLearningsObject:)
   @NSManaged
   public func removeFromLearnings(_ value: RichTextEntry)

   @objc(addLearnings:)
   @NSManaged
   public func addToLearnings(_ values: NSOrderedSet)

   @objc(removeLearnings:)
   @NSManaged
   public func removeFromLearnings(_ values: NSOrderedSet)
}

// MARK: Generated accessors for nextSteps
extension FocusTimer {
   @objc(insertObject:inNextStepsAtIndex:)
   @NSManaged
   public func insertIntoNextSteps(_ value: RichTextEntry, at idx: Int)

   @objc(removeObjectFromNextStepsAtIndex:)
   @NSManaged
   public func removeFromNextSteps(at idx: Int)

   @objc(insertNextSteps:atIndexes:)
   @NSManaged
   public func insertIntoNextSteps(_ values: [RichTextEntry], at indexes: NSIndexSet)

   @objc(removeNextStepsAtIndexes:)
   @NSManaged
   public func removeFromNextSteps(at indexes: NSIndexSet)

   @objc(replaceObjectInNextStepsAtIndex:withObject:)
   @NSManaged
   public func replaceNextSteps(at idx: Int, with value: RichTextEntry)

   @objc(replaceNextStepsAtIndexes:withNextSteps:)
   @NSManaged
   public func replaceNextSteps(at indexes: NSIndexSet, with values: [RichTextEntry])

   @objc(addNextStepsObject:)
   @NSManaged
   public func addToNextSteps(_ value: RichTextEntry)

   @objc(removeNextStepsObject:)
   @NSManaged
   public func removeFromNextSteps(_ value: RichTextEntry)

   @objc(addNextSteps:)
   @NSManaged
   public func addToNextSteps(_ values: NSOrderedSet)

   @objc(removeNextSteps:)
   @NSManaged
   public func removeFromNextSteps(_ values: NSOrderedSet)

}

// MARK: Generated accessors for problems
extension FocusTimer {
   @objc(insertObject:inProblemsAtIndex:)
   @NSManaged
   public func insertIntoProblems(_ value: RichTextEntry, at idx: Int)

   @objc(removeObjectFromProblemsAtIndex:)
   @NSManaged
   public func removeFromProblems(at idx: Int)

   @objc(insertProblems:atIndexes:)
   @NSManaged
   public func insertIntoProblems(_ values: [RichTextEntry], at indexes: NSIndexSet)

   @objc(removeProblemsAtIndexes:)
   @NSManaged
   public func removeFromProblems(at indexes: NSIndexSet)

   @objc(replaceObjectInProblemsAtIndex:withObject:)
   @NSManaged
   public func replaceProblems(at idx: Int, with value: RichTextEntry)

   @objc(replaceProblemsAtIndexes:withProblems:)
   @NSManaged
   public func replaceProblems(at indexes: NSIndexSet, with values: [RichTextEntry])

   @objc(addProblemsObject:)
   @NSManaged
   public func addToProblems(_ value: RichTextEntry)

   @objc(removeProblemsObject:)
   @NSManaged
   public func removeFromProblems(_ value: RichTextEntry)

   @objc(addProblems:)
   @NSManaged
   public func addToProblems(_ values: NSOrderedSet)

   @objc(removeProblems:)
   @NSManaged
   public func removeFromProblems(_ values: NSOrderedSet)
}

// MARK: Generated accessors for progressPoints
extension FocusTimer {
   @objc(insertObject:inProgressPointsAtIndex:)
   @NSManaged
   public func insertIntoProgressPoints(_ value: RichTextEntry, at idx: Int)

   @objc(removeObjectFromProgressPointsAtIndex:)
   @NSManaged
   public func removeFromProgressPoints(at idx: Int)

   @objc(insertProgressPoints:atIndexes:)
   @NSManaged
   public func insertIntoProgressPoints(_ values: [RichTextEntry], at indexes: NSIndexSet)

   @objc(removeProgressPointsAtIndexes:)
   @NSManaged
   public func removeFromProgressPoints(at indexes: NSIndexSet)

   @objc(replaceObjectInProgressPointsAtIndex:withObject:)
   @NSManaged
   public func replaceProgressPoints(at idx: Int, with value: RichTextEntry)

   @objc(replaceProgressPointsAtIndexes:withProgressPoints:)
   @NSManaged
   public func replaceProgressPoints(at indexes: NSIndexSet, with values: [RichTextEntry])

   @objc(addProgressPointsObject:)
   @NSManaged
   public func addToProgressPoints(_ value: RichTextEntry)

   @objc(removeProgressPointsObject:)
   @NSManaged
   public func removeFromProgressPoints(_ value: RichTextEntry)

   @objc(addProgressPoints:)
   @NSManaged
   public func addToProgressPoints(_ values: NSOrderedSet)

   @objc(removeProgressPoints:)
   @NSManaged
   public func removeFromProgressPoints(_ values: NSOrderedSet)
}
