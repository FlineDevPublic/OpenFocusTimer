import Foundation
import ComposableArchitecture
import HandySwift
import Model

public struct AppEntryPointState: Equatable {
  var currentFocusTimer: FocusTimer? = nil

  public init() {}
}

public enum AppEntryPointAction: Equatable {
  case didAppear
}
