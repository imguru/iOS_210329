
import Foundation

func removeEmojis(_ text: String) -> String {
  var scalars = text.unicodeScalars
  scalars.removeAll { e in
    e.properties.isEmoji
  }

  return String(scalars)
}

// Emoji: Command + Ctrl + Space

let message = "Hello,😘🤬 wo😘🤬rld sh😘🤬ow me t😘🤬he m😘🤬oney"
let result = removeEmojis(message)


print(result)
