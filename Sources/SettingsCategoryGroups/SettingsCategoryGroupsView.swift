import ComposableArchitecture
import Resources
import SFSafeSymbols
import SwiftUI
import Utility

public struct SettingsCategoryGroupsView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Spacer()
            HStack {
               Spacer()
               Text("SettingsCategoryGroups")
               Spacer()
            }
            Spacer()
         }
         .padding()
      }
   }

   let store: Store<SettingsCategoryGroupsState, SettingsCategoryGroupsAction>

   public init(store: Store<SettingsCategoryGroupsState, SettingsCategoryGroupsAction>) {
      self.store = store
   }
}

#if DEBUG
   struct SettingsCategoryGroupsView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(),
         reducer: settingsCategoryGroupsReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsCategoryGroupsView(store: self.store).previewVariants()
      }
   }
#endif
