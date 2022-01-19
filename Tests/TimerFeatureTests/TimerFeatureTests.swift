import XCTest
import ComposableArchitecture
@testable import TimerFeature

final class TimerFeatureTests: XCTestCase {
  let testScheduler = DispatchQueue.test

  func testTypicalTimerLifetime() {
    let customTimeLeft: TimeInterval = .minutes(25)
    let state = TimerState(timerIsRunning: false, timeLeft: customTimeLeft)
    let env = TimerEnv(mainQueue: testScheduler.eraseToAnyScheduler())

    let store = TestStore(
      initialState: state,
      reducer: timerReducer,
      environment: env
    )

    store.send(.startButtonPressed) { expectedState in
      expectedState.timerIsRunning = true
    }

    store.send(.stopButtonPressed)
    store.receive(.stopTimerRequested) { expectedState in
      expectedState.timerIsRunning = false
    }

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

    store.send(.setTimeIsUpAlert(isPresented: false)) { expectedState in
      expectedState.showTimeIsUpAlert = false
    }
    store.receive(.timerResetRequested) { expectedState in
      expectedState.timeLeft = customTimeLeft
    }
  }
}
