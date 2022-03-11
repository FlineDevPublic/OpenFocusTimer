import SwiftUI
import ComposableArchitecture
import Resources
import HandySwiftUI
import Utility

public struct ReflectionView: View {
  let store: Store<ReflectionState, ReflectionAction>

  public init(
    store: Store<ReflectionState, ReflectionAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      Form {
        self.section(
          title: L10n.Reflection.ProgressSection.title,
          placeholder: L10n.Reflection.ProgressSection.placeholder,
          textBinding: viewStore.binding(\.$progress)
        )

        self.section(
          title: L10n.Reflection.ProblemsSection.title,
          placeholder: L10n.Reflection.ProblemsSection.placeholder,
          textBinding: viewStore.binding(\.$problems)
        )

        self.section(
          title: L10n.Reflection.LearningsSection.title,
          placeholder: L10n.Reflection.LearningsSection.placeholder,
          textBinding: viewStore.binding(\.$learnings)
        )

        self.section(
          title: L10n.Reflection.NextStepsSection.title,
          placeholder: L10n.Reflection.NextStepsSection.placeholder,
          textBinding: viewStore.binding(\.$nextSteps)
        )
      }
    }
    .macOSOnly {
      $0.padding()
    }
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
        .macOSOnly {
          $0.border(.tertiary, width: 1)
        }
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
      ReflectionView(store: self.store)
        .previewVariants()
    }
  }
#endif
