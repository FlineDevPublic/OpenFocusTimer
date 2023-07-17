import ComposableArchitecture
import HandySwiftUI
import Resources
import ReusableUI
import SwiftUI
import Utility

public struct ReflectionView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         Form {
            Section {
               TitledTextEditor(
                  title: Loc.Reflection.ProgressSection.Title.string,
                  placeholder: Loc.Reflection.ProgressSection.Placeholder.string,
                  textBinding: viewStore.binding(\.$progress)
               )
            }

            Section {
               TitledTextEditor(
                  title: Loc.Reflection.ProblemsSection.Title.string,
                  placeholder: Loc.Reflection.ProblemsSection.Placeholder.string,
                  textBinding: viewStore.binding(\.$problems)
               )
            }

            Section {
               TitledTextEditor(
                  title: Loc.Reflection.LearningsSection.Title.string,
                  placeholder: Loc.Reflection.LearningsSection.Placeholder.string,
                  textBinding: viewStore.binding(\.$learnings)
               )
            }

            Section {
               TitledTextEditor(
                  title: Loc.Reflection.NextStepsSection.Title.string,
                  placeholder: Loc.Reflection.NextStepsSection.Placeholder.string,
                  textBinding: viewStore.binding(\.$nextSteps)
               )
            }

            #if os(macOS)
               HStack {
                  Spacer()

                  Button(Loc.Global.Action.Close.string) {
                     viewStore.send(.closeButtonPressed)
                  }
               }
            #endif
         }  // swift-format-ignore: RemoveLine
         #if os(iOS)
            .navigationBarItems(
               trailing: Button(Loc.Global.Action.Close.string) {
                  viewStore.send(.closeButtonPressed)
               }
            )
         #endif
      }  // swift-format-ignore: RemoveLine
      #if os(iOS)
         .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Loc.Timer.EditSummaryScreen.Title.string)
      #endif
      .macOSOnly { $0.padding() }
   }

   let store: Store<ReflectionState, ReflectionAction>

   public init(
      store: Store<ReflectionState, ReflectionAction>
   ) {
      self.store = store
   }
}

#if DEBUG
   struct ReflectionView_Previews: PreviewProvider {
      private static let store = Store(
         initialState: .mocked,
         reducer: reflectionReducer,
         environment: .mocked
      )

      static var previews: some View {
         #if os(macOS)
            ReflectionView(store: self.store)
               .previewVariants()
               .frame(height: 500)
         #else
            NavigationStack {
               ReflectionView(store: self.store)
            }
            .previewVariants()
         #endif
      }
   }
#endif
