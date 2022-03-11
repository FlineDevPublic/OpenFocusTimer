import SwiftUI

#if DEBUG
  extension View {
    public func previewVariants() -> some View {
      Group {
        self
          .previewDevice("Mac")
          .preferredColorScheme(.light)

        #warning(#"does macOS support dynamic type? `.environment(\.dynamicTypeSize, DynamicTypeSize.large)` didn't work"#)
        self
          .previewDevice("Mac")
          .preferredColorScheme(.dark)
          .environment(\.dynamicTypeSize, DynamicTypeSize.xxxLarge)

        self
          .previewDevice("iPhone 13")
          .preferredColorScheme(.light)

        self
          .previewDevice("iPhone 13")
          .preferredColorScheme(.dark)
          .environment(\.dynamicTypeSize, DynamicTypeSize.xxxLarge)
      }
    }
  }
#endif
