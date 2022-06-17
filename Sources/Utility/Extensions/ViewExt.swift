import SwiftUI

#if DEBUG
   extension View {
      public func previewVariants() -> some View {
         Group {
            self
               .previewDevice("iPhone 13")
               .previewDisplayName("iPhone 13")

            self
               .previewDevice("iPhone 8")
               .previewDisplayName("iPhone 8")

            self
               .previewDevice("Mac")
               .previewDisplayName("Mac")
         }
      }
   }
#endif
