import CategoriesSelector
import ComposableArchitecture
import Model
import ReflectionFeature
import Resources
import SFSafeSymbols
import SwiftUI

public struct TimerView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Spacer()

            CustomProgressView(currentProgress: viewStore.currentFocusTimer.currentProgress)
               .frame(maxHeight: 200)

            Text(Loc.Timer.TimeLeft.Label.string)
               .font(.headline)

            let minutes = Int(viewStore.timeLeft) / 60
            let seconds = Int(viewStore.timeLeft.truncatingRemainder(dividingBy: 60))

            Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
               .font(.largeTitle)

            if viewStore.timerIsRunning {
               Button(
                  action: { viewStore.send(.pauseButtonPressed) },
                  label: { Label(Loc.Timer.Action.Pause.string, systemSymbol: .pauseFill) }
               )
               .buttonStyle(.bordered)
               .padding()
            } else if viewStore.currentFocusTimer.runningDuration > 0 {
               Button(
                  action: { viewStore.send(.startOrContinueButtonPressed) },
                  label: { Label(Loc.Timer.Action.Continue.string, systemSymbol: .playFill) }
               )
               .buttonStyle(.bordered)
               .padding()
            } else {
               Button(
                  action: { viewStore.send(.startOrContinueButtonPressed) },
                  label: { Label(Loc.Timer.Action.Start.string, systemSymbol: .playFill) }
               )
               .buttonStyle(.bordered)
               .padding()
            }

            HStack {
               Button(Loc.Timer.EditCategoriesButton.Title.string) {
                  viewStore.send(.editCategoriesButtonPressed)
               }
               .buttonStyle(.bordered)
               .sheet(
                  isPresented: viewStore.binding(
                     get: { $0.categoriesSelectorState != nil },
                     send: TimerAction.setCategoriesSelector(isPresented:)
                  )
               ) {
                  #if os(macOS)
                     IfLetStore(
                        self.store.scope(state: \.categoriesSelectorState, action: TimerAction.categoriesSelector(action:)),
                        then: CategoriesSelectorView.init(store:)
                     )
                  #else
                     NavigationStack {
                        IfLetStore(
                           self.store.scope(state: \.categoriesSelectorState, action: TimerAction.categoriesSelector(action:)),
                           then: CategoriesSelectorView.init(store:)
                        )
                     }
                  #endif
               }

               Button(Loc.Timer.EditSummaryButton.Title.string) {
                  viewStore.send(.editSummaryButtonPressed)
               }
               .buttonStyle(.bordered)
               .sheet(
                  isPresented: viewStore.binding(
                     get: { $0.reflectionState != nil },
                     send: TimerAction.setReflection(isPresented:)
                  )
               ) {
                  #if os(macOS)
                     IfLetStore(
                        self.store.scope(state: \.reflectionState, action: TimerAction.reflection(action:)),
                        then: ReflectionView.init(store:)
                     )
                  #else
                     NavigationStack {
                        IfLetStore(
                           self.store.scope(state: \.reflectionState, action: TimerAction.reflection(action:)),
                           then: ReflectionView.init(store:)
                        )
                     }
                  #endif
               }
            }
            .padding()

            Spacer()
         }
         .alert(
            isPresented: viewStore.binding(
               get: { $0.showTimeIsUpAlert },
               send: TimerAction.setTimeIsUpAlert(isPresented:)
            )
         ) {
            Alert(
               title: Text(Loc.Timer.TimeIsUpAlert.Title.string),
               message: Text(Loc.Timer.TimeIsUpAlert.Message.string),
               primaryButton: Alert.Button.default(Text(Loc.Global.Action.Ok.string)) {
                  viewStore.send(.timerIsUpAlertDismissButtonPressed)
               },
               secondaryButton: Alert.Button.default(Text(Loc.Timer.EditSummaryButton.Title.string)) {
                  viewStore.send(.timerIsUpAlertEditSummaryButtonPressed)
               }
            )
         }
      }
   }

   let store: Store<TimerState, TimerAction>

   public init(
      store: Store<TimerState, TimerAction>
   ) {
      self.store = store
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
            .macOSOnly { $0.frame(height: 800) }
      }
   }
#endif
