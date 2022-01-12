import SwiftUI

public struct TimerView: View {
  #warning("extract into `State` once it's there")
  @State private var timerIsRunning: Bool = false

  #warning("Use `.minutes(25) through HandySwift")
  @State private var timeLeft: TimeInterval = 60 * 25

  public init() {}

  public var body: some View {
    VStack {
      Spacer()

      Text("Time left:")
        .font(.headline)

      let minutes: Int = Int(timeLeft) / 60
      let seconds: Int = Int(timeLeft.truncatingRemainder(dividingBy: 60))

      Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
        .font(.largeTitle)

      Spacer()

      if timerIsRunning {
        #warning("Use SafeSymbols as a system image reference")
        #warning("Localize the button title")
        Button(
          action: { timerIsRunning = false },
          label: { Label("Stop", systemImage: "stop.fill") }
        )
        .buttonStyle(.bordered)
        .padding()
      }
      else {
        #warning("Use SafeSymbols as a system image reference")
        #warning("Localize the button title")
        Button(
          action: { timerIsRunning = true },
          label: { Label("Start", systemImage: "play.fill") }
        )
        .buttonStyle(.bordered)
        .padding()
      }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TimerView()
    }
  }
}
