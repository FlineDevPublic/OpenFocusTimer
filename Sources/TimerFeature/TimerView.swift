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

        Text(L10n.Timer.TimeLeft.label)
          .font(.headline)

        let minutes: Int = Int(viewStore.timeLeft) / 60
        let seconds: Int = Int(viewStore.timeLeft.truncatingRemainder(dividingBy: 60))

        Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
          .font(.largeTitle)

        Spacer()

        if viewStore.timerIsRunning {
          Button(
            action: { viewStore.send(.stopButtonPressed) },
            label: { Label("Stop", systemSymbol: .stopFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }
        else {
          Button(
            action: { viewStore.send(.startButtonPressed) },
            label: { Label("Start", systemSymbol: .playFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }
      }
      .alert(
        isPresented: viewStore.binding(
          get: { $0.showTimeIsUpAlert },
          send: TimerAction.setTimeIsUpAlert(isPresented:)
        )
      ) {
        Alert(
          title: Text(L10n.Timer.TimeIsUpAlert.title),
          message: Text(L10n.Timer.TimeIsUpAlert.message),
          dismissButton: Alert.Button.default(Text(L10n.Global.Action.ok))
        )
      }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  private static let store = Store(
    initialState: .init(),
    reducer: timerReducer,
    environment: .init(mainQueue: DispatchQueue.main.eraseToAnyScheduler())
  )

  static var previews: some View {
    Group {
      TimerView(store: self.store)
    }
  }
}
