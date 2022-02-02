import XCTest
import ComposableArchitecture
@testable import Model
@testable import TimerFeature
import Utility

final class TimerFeatureTests: XCTestCase {
  let testScheduler = DispatchQueue.test

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

    store.send(.startButtonPressed)
    XCTAssertTrue(state.timerIsRunning)

    store.send(.pauseButtonPressed)
    store.receive(.pauseTimerRequested)
    XCTAssertFalse(state.timerIsRunning)

    store.send(.startButtonPressed)
    XCTAssertTrue(state.timerIsRunning)

    testScheduler.advance(by: .seconds(1))
    store.receive(.timerTicked)
    XCTAssertEqual(.minutes(24) + .seconds(59), state.timeLeft)

    testScheduler.advance(by: .seconds(24 * 60 + 59))
    (24 * 60 + 59)
      .times {
        let timeLeftBeforeTick = state.timeLeft
        store.receive(.timerTicked)
        XCTAssertEqual(timeLeftBeforeTick + .seconds(1), state.timeLeft)
      }

    testScheduler.advance(by: .seconds(1))
    store.receive(.timerTicked)
    store.receive(.pauseTimerRequested)
    XCTAssertFalse(state.timerIsRunning)

    store.receive(.setTimeIsUpAlert(isPresented: true)) { expectedState in
      expectedState.showTimeIsUpAlert = true
    }

    store.send(.setTimeIsUpAlert(isPresented: false)) { expectedState in
      expectedState.showTimeIsUpAlert = false
    }
    store.receive(.timerResetRequested)
    XCTAssertEqual(customTimeLeft, state.timeLeft)
  }
}
