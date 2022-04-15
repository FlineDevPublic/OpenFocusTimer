import ComposableArchitecture
import Utility
import XCTest

@testable import Model
@testable import TimerFeature

final class TimerFeatureTests: XCTestCase {
   private let testScheduler = DispatchQueue.test

   func testTypicalTimerLifetime() {
      let testPersistenceController = PersistenceController(inMemory: true)
      let managedObjectContext = testPersistenceController.container.viewContext
      let nowDate = Date(timeIntervalSince1970: .days(365) * 45)

      let customTimeLeft: TimeInterval = .minutes(25)
      let focusTimer = FocusTimer(
         context: managedObjectContext,
         startedAt: nowDate,
         categories: [],
         focusTopic: "Test",
         timerRunoutDuration: customTimeLeft
      )
      let state = TimerState(currentFocusTimer: focusTimer)
      let env = AppEnv(
         mainQueue: testScheduler.eraseToAnyScheduler(),
         managedObjectContext: managedObjectContext,
         nowDateProducer: { nowDate }
      )

      let store = TestStore(
         initialState: state,
         reducer: timerReducer,
         environment: env
      )

      store.send(.startOrContinueButtonPressed) { expectedState in
         expectedState.timerIsRunning = true
      }

      store.send(.pauseButtonPressed)
      store.receive(.pauseTimerRequested) { expectedState in
         expectedState.timerIsRunning = false
      }

      store.send(.startOrContinueButtonPressed) { expectedState in
         expectedState.timerIsRunning = true
      }

      testScheduler.advance(by: .seconds(1))
      store.receive(.timerTicked) { expectedState in
         expectedState.timeLeft = .minutes(24) + .seconds(59)
      }

      testScheduler.advance(by: .seconds(24 * 60 + 58))
      (24 * 60 + 58)
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

      store.send(.setTimeIsUpAlert(isPresented: false)) { expectedState in
         expectedState.showTimeIsUpAlert = false
      }
      store.receive(.timerResetRequested) { expectedState in
         expectedState.timeLeft = customTimeLeft
      }
   }
}
