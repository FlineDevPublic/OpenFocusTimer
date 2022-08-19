import Model
import Resources
import SwiftUI

struct HistoryRowView: View {
   var body: some View {
      HStack(spacing: 15) {
         Image(systemSymbol: self.focusTimer.running ? .circleLefthalfFilled : .circleFill)
            .foregroundColor(self.focusTimer.running ? .red : .secondary)

         VStack(alignment: .leading, spacing: 3) {
            Text(self.focusTimer.focusTopic ?? Loc.HistoryFeature.HistoryRow.EmptyTopic.string)
               .font(.headline)

            #warning("🧑‍💻 consider showing the icon of the categories and use their color (e.g. tags like look)")
            Text(self.focusTimer.typedCategories.compactMap(\.name).formatted())
               .font(.subheadline)

            HStack(spacing: 10) {
               Text([self.focusTimer.formattedStartTime, self.focusTimer.formattedEndTime].joined(separator: " – "))
               Text("(⏱ \(self.focusTimer.formattedRunningDuration))")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
         }
      }
   }

   let focusTimer: FocusTimer
}

extension FocusTimer {
   var formattedDayOfStart: String {
      self.startedAt?.formatted(date: .abbreviated, time: .omitted) ?? "???"
   }

   var formattedStartTime: String {
      self.startedAt?.formatted(date: .omitted, time: .shortened) ?? "???"
   }

   var formattedEndTime: String {
      self.endedAt?.formatted(date: .omitted, time: .shortened) ?? "???"
   }

   var formattedRunningDuration: String {
      let duration: Duration = .seconds(self.runningDurationInSeconds)
      return duration.formatted(.time(pattern: .hourMinuteSecond))
   }
}

struct SwiftUIView_Previews: PreviewProvider {
   static var previews: some View {
      HistoryRowView(focusTimer: .mocked)
         .padding()
   }
}

#warning("🧑‍💻 consider adding relations like learnings/nextSteps etc. in a detail view")
