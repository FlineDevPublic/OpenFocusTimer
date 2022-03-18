import SwiftUI

#if DEBUG
  extension View {
    public func previewVariants() -> some View {
      Group {
        self
          .previewDevice("Mac")
          .preferredColorScheme(.light)
          .environment(\.dynamicTypeSize, DynamicTypeSize.medium)
          .previewDisplayName("Mac: Light mode, Medium")

        #warning(#"macOS doesn't seem to support dynamic type – remove the `.dynamicTypeSize` from here?"#)
        self
          .previewDevice("Mac")
          .preferredColorScheme(.dark)
          .environment(\.dynamicTypeSize, DynamicTypeSize.xxxLarge)
          .previewDisplayName("Mac: Dark mode, XXXLarge")

        self
          .previewDevice("iPhone 13")
          .preferredColorScheme(.light)
          .environment(\.dynamicTypeSize, DynamicTypeSize.medium)
          .previewDisplayName("iPhone 13: Light mode, Medium")

        self
          .previewDevice("iPhone 8")
          .preferredColorScheme(.dark)
          .environment(\.dynamicTypeSize, DynamicTypeSize.xxxLarge)
          .previewDisplayName("iPhone 8: Dark mode, XXXLarge")
      }
    }
  }
#endif
