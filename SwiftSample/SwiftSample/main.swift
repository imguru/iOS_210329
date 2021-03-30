
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

let arr = [ 10, 8, 5, 1, 2, 7 ]
if let result = lowest(arr) {
  print(result)
}
#endif

// 오류의 원인
//   T 제약
//    - sorted() : T를 비교할 수 있어야 한다.
//      "Comparable 프로토콜을 만족해야 한다"
//       T: Comparable

func lowest<T: Comparable>(_ array: [T]) -> T? {
   return array.sorted().first
}

let arr = [ 10, 8, 5, 1, 2, 7 ]
if let result = lowest(arr) {
  print(result)
}

let arr2 = [ "hello", "abcd", "world" ]
if let result = lowest(arr2) {
  print(result)
}





