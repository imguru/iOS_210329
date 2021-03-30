
import Foundation

// 배열 안에서 최소값을 찾는 함수 - lowest
// 1) 일반 타입으로 먼저 작성해 보면 좋습니다.
#if false
func lowest(_ array: [Int]) -> Int? {
  // 오름 차순 정렬
  let sorted = array.sorted()

  // 정렬된 배열에서 첫번째 원소를 반환한다.
  return sorted.first
}
#endif
#if false
func lowest(_ array: [Int]) -> Int? {
  return array.sorted().first
}

let arr = [10, 8, 5, 1, 2, 7]
if let result = lowest(arr) {
  print(result)
}
#endif

// 오류의 원인
//   T 제약
//    - sorted() : T를 비교할 수 있어야 한다.
//      "Comparable 프로토콜을 만족해야 한다"

//   제약 표현하는 방법
//   1)  T: Comparable
#if false
func lowest<T: Comparable>(_ array: [T]) -> T? {
  return array.sorted().first
}
#endif

//   2) where T: Comprable
func lowest<T>(_ array: [T]) -> T? where T: Comparable {
  return array.sorted().first
}

let arr = [10, 8, 5, 1, 2, 7]
if let result = lowest(arr) {
  print(result)
}

let arr2 = ["hello", "abcd", "world"]
if let result = lowest(arr2) {
  print(result)
}

struct User {
  let age: Int
}

let arr3 = [
  User(age: 30),
  User(age: 10),
  User(age: 20),
]

extension User: Comparable {
  static func < (lhs: User, rhs: User) -> Bool {
    return lhs.age > rhs.age
  }
}

if let result = lowest(arr3) {
  print(result)
}

enum School {
  case high
  case middle
  case elementary
}

let arr4: [School] = [
  .elementary,
  .high,
  .middle,
]

// enum의 Comparable의 구현을 제공하지 않을 경우, case의 순서에 따라 자동으로 결정됩니다.
extension School: Comparable {
  static func < (lhs: School, rhs: School) -> Bool {
    switch (lhs, rhs) {
    case (elementary, middle):
      return true
    case (elementary, high):
      return true
    case (middle, high):
      return true
    default:
      return false
    }
  }
}

if let result = lowest(arr4) {
  print(result)
}
