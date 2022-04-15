import ComposableArchitecture
import CoreData
import Model
import Utility

public let reflectionReducer = Reducer<ReflectionState, ReflectionAction, AppEnv> { state, action, env in
   switch action {
   case .binding(\.$progress):
      handleReflectionTextChange(
         typedRelationKeyPath: \.typedProgressPoints,
         textKeyPath: \.progress,
         state: &state,
         env: env
      )

   case .binding(\.$learnings):
      handleReflectionTextChange(
         typedRelationKeyPath: \.typedLearnings,
         textKeyPath: \.learnings,
         state: &state,
         env: env
      )

   case .binding(\.$problems):
      handleReflectionTextChange(
         typedRelationKeyPath: \.typedProblems,
         textKeyPath: \.problems,
         state: &state,
         env: env
      )

   case .binding(\.$nextSteps):
      handleReflectionTextChange(
         typedRelationKeyPath: \.typedNextSteps,
         textKeyPath: \.nextSteps,
         state: &state,
         env: env
      )

   case .closeButtonPressed:
      break  // handled by parent reducer

   case .binding:
      break
   }

   return .none
}
.binding()

/// Handles rich text entry relation binding text change by updating the related obect in CoreData.
///
/// - Parameters:
///   - typedRelationKeyPath: Key path to the `typed` relation on the `FocusTimer` model to be updated. E.g. `\.typedProgressPoints`.
///   - textKeyPath: Key path to the text the user entered for the `ReflectionState` property to be changed. E.g. `\.progress`.
///   - state: The reducers state object.
///   - env: The reducers environment object.
private func handleReflectionTextChange(
   typedRelationKeyPath: WritableKeyPath<FocusTimer, [RichTextEntry]>,
   textKeyPath: WritableKeyPath<ReflectionState, String>,
   state: inout ReflectionState,
   env: AppEnv
) {
   #warning("add support for multiple texts")

   var textEntry = state.focusTimer[keyPath: typedRelationKeyPath].first

   if textEntry == nil {
      guard !state[keyPath: textKeyPath].isBlank else { return }

      textEntry = RichTextEntry(
         context: env.managedObjectContext,
         text: state[keyPath: textKeyPath],
         focusTimer: state.focusTimer
      )
      #warning("performance: consider removing this to prevent unnecessary saves")
      try! env.managedObjectContext.save()
   } else {
      guard !state[keyPath: textKeyPath].isBlank else {
         state.focusTimer[keyPath: typedRelationKeyPath] = []
         env.managedObjectContext.delete(textEntry!)
         try! env.managedObjectContext.save()
         return
      }

      textEntry?.text = state[keyPath: textKeyPath]
   }

   state.focusTimer[keyPath: typedRelationKeyPath] = [textEntry!]
   try! env.managedObjectContext.save()
}
