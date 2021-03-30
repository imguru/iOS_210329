
import Foundation

enum LogError: Error {
  case invalidValue
}

struct Log {
  var values = [String]()

  #if false
  mutating func append(messages: [String]) throws {
    for message in messages {
      let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)

      if trimmed.isEmpty {
        throw LogError.invalidValue
      }

      values.append(message)
    }
  }
  #endif
  
  // 2. 연산이 완료된 이후에 객체의 상태가 변경되도록 해야 한다.
  //   => 복사본을 이용하는 것이 좋습니다.
  mutating func append(messages: [String]) throws {
    var temp = values
    for message in messages {
      let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)

      if trimmed.isEmpty {
        throw LogError.invalidValue
      }

      temp.append(message)
    }
    values = temp
  }
  
}

// 1. 오류 가능성이 있는 연산이 수행되었을 때,
//    오류가 발생하게 되면, 오류 발생 이전의 객체 상태로 오류 발생 이후의 상태는 동일해야 한다. => 예외 안정성
var log = Log()
print(log)

do {
  try log.append(messages: [
    "hello, world",
    "                 ",
    "show me the money",
  ])
} catch {
  print(error)
}

print(log)
