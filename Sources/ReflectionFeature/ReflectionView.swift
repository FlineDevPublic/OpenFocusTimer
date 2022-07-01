import ComposableArchitecture
import HandySwiftUI
import Resources
import SwiftUI
import Utility

public struct ReflectionView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         Form {
            self.section(
               title: Loc.Reflection.ProgressSection.Title.string,
               placeholder: Loc.Reflection.ProgressSection.Placeholder.string,
               textBinding: viewStore.binding(\.$progress)
            )

            self.section(
               title: Loc.Reflection.ProblemsSection.Title.string,
               placeholder: Loc.Reflection.ProblemsSection.Placeholder.string,
               textBinding: viewStore.binding(\.$problems)
            )

            self.section(
               title: Loc.Reflection.LearningsSection.Title.string,
               placeholder: Loc.Reflection.LearningsSection.Placeholder.string,
               textBinding: viewStore.binding(\.$learnings)
            )

            self.section(
               title: Loc.Reflection.NextStepsSection.Title.string,
               placeholder: Loc.Reflection.NextStepsSection.Placeholder.string,
               textBinding: viewStore.binding(\.$nextSteps)
            )

            #if os(macOS)
               HStack {
                  Spacer()

                  Button(Loc.Global.Action.Close.locStringKey) {
                     viewStore.send(.closeButtonPressed)
                  }
               }
            #endif
         }  // swift-format-ignore: RemoveLine
         #if os(iOS)
            .navigationBarItems(
               trailing: Button(Loc.Global.Action.Close.locStringKey) {
                  viewStore.send(.closeButtonPressed)
               }
            )
         #endif
      }  // swift-format-ignore: RemoveLine
      #if os(iOS)
         .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Loc.Timer.EditSummaryScreen.Title.locStringKey)
      #endif
      .macOSOnly { $0.padding() }
   }

   let store: Store<ReflectionState, ReflectionAction>

   public init(
      store: Store<ReflectionState, ReflectionAction>
   ) {
      self.store = store
   }

   private func section(title: String, placeholder: String, textBinding: Binding<String>) -> some View {
      Section {
         VStack(alignment: .leading) {
            Text(title)
               .font(.title2)

            Text(placeholder)
               .foregroundColor(Color.secondary)
         }

         TextEditor(text: textBinding)
            .macOSOnly { $0.border(.tertiary, width: 1) }
            .frame(minHeight: 44)

         #if os(macOS)
            Spacer().frame(height: 15)
         #endif
      }
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
