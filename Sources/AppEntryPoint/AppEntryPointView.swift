import SwiftUI
import CoreData
import Model
import TimerFeature
import ComposableArchitecture
import ReflectionFeature

public struct AppEntryPointView: View {
  let store: Store<AppEntryPointState, AppEntryPointAction>

  public init(
    store: Store<AppEntryPointState, AppEntryPointAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationView {
        HStack {
          Spacer()

          IfLetStore(
            self.store.scope(state: \.timerState, action: AppEntryPointAction.timer(action:)),
            then: TimerView.init(store:)
          )

          Spacer()

          Divider()

          Spacer()

          IfLetStore(
            self.store.scope(state: \.reflectionState, action: AppEntryPointAction.reflection(action:)),
            then: ReflectionView.init(store:)
          )

          Spacer()
        }
      }
      .onAppear {
        viewStore.send(.didAppear)
      }
    }
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    private static let store = Store(
      initialState: .init(),
      reducer: appEntryPointReducer,
      environment: .mocked
    )

    static var previews: some View {
      AppEntryPointView(store: store)
    }
  }
#endif
