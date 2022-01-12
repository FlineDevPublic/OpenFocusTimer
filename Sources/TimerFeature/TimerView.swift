import SwiftUI
import SFSafeSymbols

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
        #warning("Localize the button title")
        Button(
          action: { timerIsRunning = false },
          label: { Label("Stop", systemSymbol: .stopFill) }
        )
        .buttonStyle(.bordered)
        .padding()
      }
      else {
        #warning("Localize the button title")
        Button(
          action: { timerIsRunning = true },
          label: { Label("Start", systemSymbol: .playFill) }
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
