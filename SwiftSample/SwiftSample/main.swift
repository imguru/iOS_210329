
import Foundation

func removeEmojis(_ text: String) -> String {
  var scalars = text.unicodeScalars
  scalars.removeAll { e in
    e.properties.isEmoji
  }

  return String(scalars)
}

// Emoji: Command + Ctrl + Space
let message: String? = "Hello,😘🤬 wo😘🤬rl🍅d sh😘🤬ow m🍅e t😘🤬he m😘🤬oney"
if let message = message {
  let result = removeEmojis(message)
  print(result)
}

// [ T ]            -> map  -> [ U ]
// Optional<T>      -> map  -> Optional<U>

// message: String? -> map ->

let result = message.map { message in
  removeEmojis(message)
}
if let result = result {
  print(result)
}

// print(result)





#if false
let message = "Hello,😘🤬 wo😘🤬rl🍅d sh😘🤬ow m🍅e t😘🤬he m😘🤬oney"
let result = removeEmojis(message)

print(result)
#endif
