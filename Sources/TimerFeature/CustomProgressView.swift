import SwiftUI

struct CustomProgressView: View {
   /// The current progress as a value between 0.0 and 1.0. 1.0 = 100% completed.
   var currentProgress: Double

   var body: some View {
      Circle()
         .trim(from: 0, to: CGFloat(min(self.currentProgress, 1.0)))
         .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
         .rotation(SwiftUI.Angle.degrees(-90))
         .foregroundColor(.accentColor)
         .frame(maxWidth: 100)
         .animation(
            .linear(duration: .seconds(1)),
            value: self.currentProgress
         )
   }
}

struct SwiftUIView_Previews: PreviewProvider {
   static var previews: some View {
      CustomProgressView(currentProgress: 0.75)
   }
}
