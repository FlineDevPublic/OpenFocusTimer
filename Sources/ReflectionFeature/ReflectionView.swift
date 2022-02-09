import SwiftUI
import ComposableArchitecture
import Resources

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
          textBinding: viewStore.binding(
            get: \.progress,
            send: ReflectionAction.setProgress
          )
        )

        self.section(
          title: L10n.Reflection.ProblemsSection.title,
          placeholder: L10n.Reflection.ProblemsSection.placeholder,
          textBinding: viewStore.binding(
            get: \.problems,
            send: ReflectionAction.setProblems
          )
        )

        self.section(
          title: L10n.Reflection.LearningsSection.title,
          placeholder: L10n.Reflection.LearningsSection.placeholder,
          textBinding: viewStore.binding(
            get: \.learnings,
            send: ReflectionAction.setLearnings
          )
        )

        self.section(
          title: L10n.Reflection.NextStepsSection.title,
          placeholder: L10n.Reflection.NextStepsSection.placeholder,
          textBinding: viewStore.binding(
            get: \.nextSteps,
            send: ReflectionAction.setNextSteps
          )
        )
      }
    }
  }

  private func section(title: String, placeholder: String, textBinding: Binding<String>) -> some View {
    Section {
      Text(title)
        .font(.headline)

      TextField(placeholder, text: textBinding)
    }
  }
}

#if DEBUG
  struct ReflectionView_Previews: PreviewProvider {
    #warning("CONTINUE HERE: create a mock for the reflection store")
    private static let store = Store(
      initialState: .mocked,
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
