import SwiftUI
import SFSafeSymbols
import Resources
import ComposableArchitecture

public struct TimerView: View {
  let store: Store<TimerState, TimerAction>

  public init(
    store: Store<TimerState, TimerAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        Spacer()

        Text("Time left:")
          .font(.headline)

        let minutes: Int = Int(viewStore.timeLeft) / 60
        let seconds: Int = Int(viewStore.timeLeft.truncatingRemainder(dividingBy: 60))

        Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
          .font(.largeTitle)

        Spacer()

        if viewStore.timerIsRunning {
          #warning("Localize the button title")
          Button(
            action: { viewStore.send(.startButtonPressed) },
            label: { Label("Stop", systemSymbol: .stopFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }
        else {
          #warning("Localize the button title")
          Button(
            action: { viewStore.send(.stopButtonPressed) },
            label: { Label("Start", systemSymbol: .playFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }
      }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  private static let store = Store(
    initialState: .init(),
    reducer: timerReducer,
    environment: .init()
  )

  static var previews: some View {
    Group {
      TimerView(store: self.store)
    }
  }
}
