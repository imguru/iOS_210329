
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

// commitCount가 0이 아닌 데이터를 정렬해서 반환한다.
#if false
func counts(stat: [User]) -> [Int] {
  var counts = [Int]()

  #if false
  for user in stat {
    if user.commitCount > 0 {
      counts.append(user.commitCount)
    }
  }
  #endif

  // filter
  // map
  for user in stat where user.commitCount > 0 {
    counts.append(user.commitCount)
  }

  // return counts.sorted()  // <
  #if false
  return counts.sorted { (a, b) -> Bool in
    a > b
  }
  #endif

  
  // sort
  return counts.sorted(by: >)
}
#endif
// N + NlogN

// 선언적인 코드 - '가독성'이 좋다
//   문제점: 불필요한 루프로 인해 성능 처리에 문제가 될수 있습니다.
//         직접 알고리즘을 작성하는 것이 효율적일 수 있습니다.
func counts(stat: [User]) -> [Int] {
  return stat
    .filter { e in         // N
      e.commitCount > 0
    }
    .map { e in            // N
      e.commitCount
    }
    .sorted(by: <)         // NlogN
}

// -------

let commitsPerUser: [User] = [
  User(name: "Tom", commitCount: 30),
  User(name: "Bob", commitCount: 150),
  User(name: "Alice", commitCount: 0)
]

let result = resolveCounts(stat: commitsPerUser)
print(result)

let result2 = counts(stat: commitsPerUser)
print(result2)
