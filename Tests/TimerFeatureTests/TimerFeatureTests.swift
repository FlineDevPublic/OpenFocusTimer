import ComposableArchitecture
import Utility
import XCTest

@testable import CategoriesSelector
@testable import Model
@testable import ReflectionFeature
@testable import TimerFeature

final class TimerFeatureTests: XCTestCase {
   private let testScheduler = DispatchQueue.test

   func testTypicalTimerLifetime() {
      // set up test data
      let testPersistenceController = PersistenceController(inMemory: true)
      let context = testPersistenceController.container.viewContext
      let nowDate = Date(timeIntervalSince1970: .days(365) * 45)

      let taskTypeCategoryGroup = CategoryGroup(context: context, name: "Task Type")
      let categoryCodeReview = Category(
         context: context,
         name: "Code Review",
         color: .yellow,
         icon: .checkmarkSeal,
         group: taskTypeCategoryGroup
      )
      let categoryProgramming = Category(
         context: context,
         name: "Programming",
         color: .blue,
         icon: .chevronLeftForwardslashChevronRight,
         group: taskTypeCategoryGroup
      )

      let projectCategoryGroup = CategoryGroup(context: context, name: "Project")
      let categoryMainProject = Category(
         context: context,
         name: "Main Project",
         color: .orange,
         icon: ._1Circle,
         group: projectCategoryGroup
      )
      let categorySideProject = Category(
         context: context,
         name: "Side Project",
         color: .purple,
         icon: ._2Square,
         group: projectCategoryGroup
      )

      let customTimeLeft: TimeInterval = .minutes(25)
      let focusTimer = FocusTimer(
         context: context,
         startedAt: nowDate,
         categories: [],
         focusTopic: "Test",
         timerRunoutDuration: customTimeLeft
      )
      let state = TimerState(currentFocusTimer: focusTimer)
      let env = AppEnv(
         mainQueue: testScheduler.eraseToAnyScheduler(),
         managedObjectContext: context,
         nowDateProducer: { nowDate }
      )

      // start of the test
      let store = TestStore(
         initialState: state,
         reducer: timerReducer,
         environment: env
      )

      // click start button
      store.send(.startOrContinueButtonPressed) { expectedState in
         expectedState.timerIsRunning = true
      }
      store.receive(.setCategoriesSelector(isPresented: true)) { expectedState in
         expectedState.categoriesSelectorState = .init(focusTimer: focusTimer, context: context)
      }

      XCTAssertNoDifference([:], store.state.categoriesSelectorState?.selectedGroupCategories)

      // let 1 second pass
      testScheduler.advance(by: .seconds(1))
      store.receive(.timerTicked) { expectedState in
         expectedState.timeLeft = .minutes(24) + .seconds(59)
      }

      // set both categories
      store.send(
         .categoriesSelector(action: .categoryGroupSelectionChanged(group: taskTypeCategoryGroup, category: categoryProgramming))
      ) { expectedState in
         expectedState.categoriesSelectorState?.selectedGroupCategories = [taskTypeCategoryGroup: categoryProgramming]
      }

      store.send(
         .categoriesSelector(action: .categoryGroupSelectionChanged(group: projectCategoryGroup, category: categorySideProject))
      ) { expectedState in
         expectedState.categoriesSelectorState?.selectedGroupCategories = [
            taskTypeCategoryGroup: categoryProgramming,
            projectCategoryGroup: categorySideProject,
         ]
      }

      // let 1 more second pass
      testScheduler.advance(by: .seconds(1))
      store.receive(.timerTicked) { expectedState in
         expectedState.timeLeft = .minutes(24) + .seconds(58)
      }

      // close categories selector
      store.send(.categoriesSelector(action: .closeButtonPressed))
      store.receive(.setCategoriesSelector(isPresented: false)) { expectedState in
         expectedState.categoriesSelectorState = nil
      }

      // let 1 more second pass
      testScheduler.advance(by: .seconds(1))
      store.receive(.timerTicked) { expectedState in
         expectedState.timeLeft = .minutes(24) + .seconds(57)
      }

      // click pause button
      store.send(.pauseButtonPressed)
      store.receive(.pauseTimerRequested) { expectedState in
         expectedState.timerIsRunning = false
      }

      // let 5 more seconds pass
      testScheduler.advance(by: .seconds(1))

      // click continue button
      store.send(.startOrContinueButtonPressed) { expectedState in
         expectedState.timerIsRunning = true
      }

      // let 1 more second pass
      testScheduler.advance(by: .seconds(1))
      store.receive(.timerTicked) { expectedState in
         expectedState.timeLeft = .minutes(24) + .seconds(56)
      }

      testScheduler.advance(by: .seconds(24 * 60 + 55))
      (24 * 60 + 55)
         .times {
            store.receive(.timerTicked) { expectedState in
               expectedState.timeLeft -= .seconds(1)
            }
         }

      testScheduler.advance(by: .seconds(1))
      store.receive(.timerTicked) { expectedState in
         expectedState.timerIsRunning = false
         expectedState.timeLeft = 0
      }

      store.receive(.setTimeIsUpAlert(isPresented: true)) { expectedState in
         expectedState.showTimeIsUpAlert = true
      }

      store.send(.timerIsUpAlertEditSummaryButtonPressed)
      store.receive(.setReflection(isPresented: true)) { expectedState in
         expectedState.reflectionState = .init(focusTimer: focusTimer)
      }

      store.send(.reflection(action: .set(\.$progress, "We've introduces Sign In with Apple."))) { expectedState in
         expectedState.reflectionState?.progress = "We've introduces Sign In with Apple."
      }
      store.send(.reflection(action: .set(\.$learnings, "Sign I with Apple is easy as pie!"))) { expectedState in
         expectedState.reflectionState?.learnings = "Sign I with Apple is easy as pie!"
      }

      XCTAssertNoDifference(focusTimer.typedProgressPoints.map(\.text), ["We've introduces Sign In with Apple."])
      XCTAssertNoDifference(focusTimer.typedLearnings.map(\.text), ["Sign I with Apple is easy as pie!"])

      store.send(.reflection(action: .closeButtonPressed))

      #warning("🧑‍💻 no idea why the focus timer here doesn't update, investigate & fix")
      store.receive(.timerResetRequested)

      #warning("🧑‍💻 make sure that the now date producer changes when the test schedulers date is adanced")
      XCTAssertNoDifference(focusTimer.endedAt, nowDate.addingTimeInterval(.minutes(25)))

      store.receive(.setReflection(isPresented: false)) { expectedState in
         expectedState.reflectionState = nil
      }
   }
}

extension Model.Category: CustomDumpStringConvertible {
   public var customDumpDescription: String {
      self.name ?? "?"
   }
}

extension CategoryGroup: CustomDumpStringConvertible {
   public var customDumpDescription: String {
      self.name ?? "?"
   }
}

extension FocusTimer: CustomDumpStringConvertible {
   public var customDumpDescription: String {
      """
      {
         startedAt: \(self.startedAt?.formatted())
         endedAt: \(self.endedAt?.formatted())

         progressPoints: \(self.typedProgressPoints.map(\.text))
         typedLearnings: \(self.typedLearnings.map(\.text))
         typedProblems: \(self.typedProblems.map(\.text))
         typedNextSteps: \(self.typedNextSteps.map(\.text))
      }
      """
   }
}
