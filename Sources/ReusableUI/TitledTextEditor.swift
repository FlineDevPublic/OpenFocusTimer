import SwiftUI
import HandySwiftUI

public struct TitledTextEditor: View {
   let title: String
   let placeholder: String
   let textBinding: Binding<String>

   public init(title: String, placeholder: String, textBinding: Binding<String>) {
      self.title = title
      self.placeholder = placeholder
      self.textBinding = textBinding
   }

   public var body: some View {
      VStack(alignment: .leading) {
         Text(self.title)
            .font(.title2)

         Text(self.placeholder)
            .foregroundColor(Color.secondary)
      }

      TextEditor(text: self.textBinding)
         .macOSOnly { $0.border(.tertiary, width: 1) }
         .frame(minHeight: 44)

      #if os(macOS)
         Spacer().frame(height: 15)
      #endif
   }
}

struct TextEditorSection_Previews: PreviewProvider {
   static var previews: some View {
      Form {
         TitledTextEditor(
            title: "Some title",
            placeholder: "e.g. some placeholder",
            textBinding: .constant("Some user-provided text typed into this field.")
         )
      }
   }
}
