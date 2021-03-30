
import Foundation

enum LogError: Error {
  case invalidValue
}

struct Log {
  var values = [String]()

  mutating func append(messages: [String]) throws {
    for message in messages {
      let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)

      if trimmed.isEmpty {
        throw LogError.invalidValue
      }

      values.append(message)
    }
  }
}

var log = Log()

try log.append(messages: [
  "hello, world",
  "show me the money",
])

print(log)




