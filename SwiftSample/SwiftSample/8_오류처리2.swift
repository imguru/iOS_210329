
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

func writeToFiles(data: [URL: String]) throws {
  var completed = [URL]()

  // defer 블록에서는 외부로 예외를 전파할 수 없다.
  // try!: 예외가 발생하였을 경우 비정상 종료합니다.
  defer {
    if completed.count != data.count { // 오류가 발생하였다
      print("예외가 발생하였습니다.")

      for url in completed {
        do {
          try FileManager.default.removeItem(at: url)
        } catch {
          print("복구할 수 없는 오류가 발생하였습니다.")
        }
      }
    }
  }

  for (url, contents) in data {
    try contents.write(to: url, atomically: true, encoding: .utf8)
    completed.append(url)
  }
}

do {
  try writeToFiles(data: [
    URL(fileURLWithPath: "/Users/ourguide/Desktop/a.txt"): "hello world",
    URL(fileURLWithPath: "~/b.txt"): "hello world",
    URL(fileURLWithPath: "/Users/ourguide/Desktop/c.txt"): "hello world",
  ])
} catch {
  print(error)
}

// 정리
// - 함수에 오류가 발생하였을 때 이전의 상태로 복원하는 방법 - 예외 안정성
//  => 오류 이전의 객체 상태가 보장되어야, 해당 객체를 계속 이용할 수 있다.
// 1. 임시 변수를 활용해서, 연산이 완료된 이후에 객체의 상태를 변경한다.
// 2. defer를 이용해서, 연산의 이전 상태로 복구하는 연산을 수행한다.

// 3. '불변 객체'로 설계하면, 문제를 고민할 필요가 없습니다.
enum UserError : Error {
  case invalidAge
}

struct User {
  let name: String
  let age: Int

  func child(childAge: Int) throws -> User {
    if age <= childAge {
      throw UserError.invalidAge
    }
    
    return User(name: "JR.\(name)" , age: childAge)
  }
}

let user = User(name: "Tom", age: 42)
print(user)
do {
  let jr = try user.child(childAge: 50)
  print(jr)
} catch {
  print(error)
}
print(user)
