import ComposableArchitecture
import SFSafeSymbols
import SwiftUI
import Utility

public struct SettingsCategoriesView: View {
   public var body: some View {
      WithViewStore(self.store) { viewStore in
         VStack {
            Spacer()
            HStack {
               Spacer()
               Text("SettingsCategories 2")
               Spacer()
            }
            Spacer()
         }
         .padding()
      }
   }

   let store: Store<SettingsCategoriesState, SettingsCategoriesAction>

   public init(store: Store<SettingsCategoriesState, SettingsCategoriesAction>) {
      self.store = store
   }
}

#if DEBUG
   struct SettingsCategoriesView_Previews: PreviewProvider {
      static let store = Store(
         initialState: .init(),
         reducer: settingsCategoriesReducer,
         environment: .mocked
      )

      static var previews: some View {
         SettingsCategoriesView(store: self.store).previewVariants()
      }
   }
#endif
