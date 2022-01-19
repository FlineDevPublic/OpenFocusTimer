import XCTest
import ComposableArchitecture
@testable import TimerFeature

final class TimerFeatureTests: XCTestCase {
  let testScheduler = DispatchQueue.test

  func testTypicalTimerLifetime() {
    let state = TimerState(timerIsRunning: false, timeLeft: .minutes(25))
    let env = TimerEnv(mainQueue: testScheduler.eraseToAnyScheduler())

    let store = TestStore(
      initialState: state,
      reducer: timerReducer,
      environment: env
    )

    store.send(.startButtonPressed) { expectedState in
      expectedState.timerIsRunning = true
    }

    #warning("assert that a timer effect is running in the background")

    store.send(.stopButtonPressed)
    store.receive(.stopTimerRequested) { expectedState in
      expectedState.timerIsRunning = false
    }

    #warning("assert that the timer effect is cancelled")

    store.send(.startButtonPressed) { expectedState in
      expectedState.timerIsRunning = true
    }

    testScheduler.advance(by: .seconds(1))
    store.receive(.timerTicked) { expectedState in
      expectedState.timeLeft = .minutes(24) + .seconds(59)
    }

    testScheduler.advance(by: .seconds(24 * 60 + 59))
    (24 * 60 + 59)
      .times {
        store.receive(.timerTicked) { expectedState in
          expectedState.timeLeft -= .seconds(1)
        }
      }

    testScheduler.advance(by: .seconds(1))
    store.receive(.timerTicked)
    store.receive(.stopTimerRequested) { expectedState in
      expectedState.timerIsRunning = false
    }
    store.receive(.timeIsUp)
    store.receive(.setTimeIsUpAlert(isPresented: true)) { expectedState in
      expectedState.showTimeIsUpAlert = true
    }
  }
}
