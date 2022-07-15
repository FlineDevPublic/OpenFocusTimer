import ComposableArchitecture
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct StatisticsFeatureView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Spacer()
            HStack {
               Spacer()
               Text("StatisticsFeature")
               Spacer()
            }
            Spacer()
         }
         .padding()
      }
   }

   let store: Store<StatisticsFeatureState, StatisticsFeatureAction>

   public init(store: Store<StatisticsFeatureState, StatisticsFeatureAction>) {
      self.store = store
   }
}

#if DEBUG
   struct StatisticsFeatureView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(),
         reducer: statisticsFeatureReducer,
         environment: .mocked
      )

      static var previews: some View {
         StatisticsFeatureView(store: self.store).previewVariants()
      }
   }
#endif
