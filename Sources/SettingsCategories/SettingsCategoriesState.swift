import ComposableArchitecture
import Foundation
import HandySwift

public struct SettingsCategoriesState: Equatable {
   // add State properties here

   public init() {}
}

#if DEBUG
   extension SettingsCategoriesState: Withable {}
#endif
