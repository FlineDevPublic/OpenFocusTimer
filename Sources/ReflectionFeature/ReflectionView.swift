import SwiftUI
import ComposableArchitecture

public struct ReflectionView: View {
  let store: Store<ReflectionState, ReflectionAction>

  public init(
    store: Store<ReflectionState, ReflectionAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("Hello World")
    }
  }
}

#if DEBUG
  struct ReflectionView_Previews: PreviewProvider {
    private static let store = Store(
      initialState: .init(),
      reducer: reflectionReducer,
      environment: .mocked
    )

    static var previews: some View {
      Group {
        ReflectionView(store: self.store)
      }
    }
  }
#endif
