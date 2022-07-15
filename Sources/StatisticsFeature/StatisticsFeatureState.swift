import ComposableArchitecture
import Foundation
import HandySwift

public struct StatisticsFeatureState: Equatable {
   // add State properties here

   public init() {}
}

#if DEBUG
   extension StatisticsFeatureState: Withable {}
#endif
