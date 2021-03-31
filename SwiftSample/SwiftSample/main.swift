
import Foundation

// Collection / Sequence
//  - map
//    : transform 으로도 부르는 언어가 있습니다.

struct User {
  let name: String
  let commitCount: Int
}
func resolveCounts(stat: [User]) -> [String] {
  var result = [String]()
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
  return result
}

let commitsPerUser: [User] = [
  User(name: "Tom", commitCount: 30),
  User(name: "Bob", commitCount: 150),
  User(name: "Alice", commitCount: 0)
]

let result = resolveCounts(stat: commitsPerUser)
print(result)
