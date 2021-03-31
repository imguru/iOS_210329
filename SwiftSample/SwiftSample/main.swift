
import Foundation

// Collection / Sequence
//  - map
//    : transform 으로도 부르는 언어가 있습니다.

struct User {
  let name: String
  let commitCount: Int
}

#if false
// 1. for-loop
func resolveCounts(stat: [User]) -> [String] {
  var result = [String]()

  for user in stat {
    let message: String
    switch user.commitCount {
    case 0:
      message = "\(user.name): 아무것도 안함"
    case 1 ..< 100:
      message = "\(user.name): 열심히 안함"
    default:
      message = "\(user.name): 열심히 했음"
    }

    result.append(message)
  }

  #if false
  for user in stat {
    var message = ""
    switch user.commitCount {
    case 0:
      message = "\(user.name): 아무것도 안함"
    case 1 ..< 100:
      message = "\(user.name): 열심히 안함"
    default:
      message = "\(user.name): 열심히 했음"
    }

    result.append(message)
  }
  #endif

  return result
}
#endif

// 2. map
//   [T] -> map -> [U]
func resolveCounts(stat: [User]) -> [String] {
  return stat.map { user -> String in
    let message: String
    switch user.commitCount {
    case 0:
      message = "\(user.name): 아무것도 안함"
    case 1 ..< 100:
      message = "\(user.name): 열심히 안함"
    default:
      message = "\(user.name): 열심히 했음"
    }
    return message
  }
}

let commitsPerUser: [User] = [
  User(name: "Tom", commitCount: 30),
  User(name: "Bob", commitCount: 150),
  User(name: "Alice", commitCount: 0)
]

let result = resolveCounts(stat: commitsPerUser)
print(result)
