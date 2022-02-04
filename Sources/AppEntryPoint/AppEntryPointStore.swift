import Foundation
import ComposableArchitecture
import HandySwift
import Model
import TimerFeature
import ReflectionFeature

public struct AppEntryPointState: Equatable {
  var timerState: TimerState?
  var reflectionState: ReflectionState?

  public init() {}
}

public enum AppEntryPointAction: Equatable {
  case didAppear
  case timer(action: TimerAction)
  case reflection(action: ReflectionAction)
}
