import SwiftUI
import SFSafeSymbols
import Resources
import ComposableArchitecture
import Model
import ReflectionFeature

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
        Text(L10n.Timer.TimeLeft.label)
          .font(.headline)

        let minutes: Int = Int(viewStore.timeLeft) / 60
        let seconds: Int = Int(viewStore.timeLeft.truncatingRemainder(dividingBy: 60))

        Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
          .font(.largeTitle)

        if viewStore.timerIsRunning {
          Button(
            action: { viewStore.send(.pauseButtonPressed) },
            label: { Label(L10n.Timer.Action.pause, systemSymbol: .pauseFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }
        else if viewStore.currentFocusTimer.runningDuration > 0 {
          Button(
            action: { viewStore.send(.startOrContinueButtonPressed) },
            label: { Label(L10n.Timer.Action.continue, systemSymbol: .playFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }
        else {
          Button(
            action: { viewStore.send(.startOrContinueButtonPressed) },
            label: { Label(L10n.Timer.Action.start, systemSymbol: .playFill) }
          )
          .buttonStyle(.bordered)
          .padding()
        }

        Divider()

        IfLetStore(
          self.store.scope(state: \.reflectionState, action: TimerAction.reflection(action:)),
          then: ReflectionView.init(store:)
        )
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
      .onAppear {
        viewStore.send(.didAppear)
      }
    }
  }
}

#if DEBUG
  struct TimerView_Previews: PreviewProvider {
    private static let store = Store(
      initialState: .init(currentFocusTimer: .mocked),
      reducer: timerReducer,
      environment: .mocked
    )

    static var previews: some View {
      TimerView(store: self.store)
        .previewVariants()
    }
  }
#endif
