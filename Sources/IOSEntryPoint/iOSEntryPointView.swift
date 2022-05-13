import ComposableArchitecture
import MainFeature
import Resources
import SFSafeSymbols
import Settings
import SwiftUI
import TimerFeature
import Utility

public struct IOSEntryPointView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         TabView(selection: viewStore.binding(\.$selectedTab)) {
            TimerView(
               store: self.store.scope(
                  state: \.timerState,
                  action: IOSEntryPointAction.timer(action:)
               )
            )
            .tabItem {
               Label("Timer", systemSymbol: .stopwatch)
            }
            .tag(IOSEntryPointState.TabItem.timer)

            MainFeatureView(
               store: self.store.scope(
                  state: \.mainFeatureState,
                  action: IOSEntryPointAction.mainFeature(action:)
               )
            )
            .tabItem {
               Label("Main", systemSymbol: .house)
            }
            .tag(IOSEntryPointState.TabItem.main)

            SettingsView(
               store: self.store.scope(
                  state: \.settingsState,
                  action: IOSEntryPointAction.settings(action:)
               )
            )
            .tabItem {
               Label("Settings", systemSymbol: .gear)
            }
            .tag(IOSEntryPointState.TabItem.settings)
         }
      }
   }

   let store: Store<IOSEntryPointState, IOSEntryPointAction>

   public init(store: Store<IOSEntryPointState, IOSEntryPointAction>) {
      self.store = store
   }
}

#if DEBUG
   struct IOSEntryPointView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(context: .mocked, currentFocusTimer: .mocked),
         reducer: iOSEntryPointReducer,
         environment: .mocked
      )

      static var previews: some View {
         IOSEntryPointView(store: self.store).previewVariants()
      }
   }
#endif
