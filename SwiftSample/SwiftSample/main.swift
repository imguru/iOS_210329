
import Foundation

// Sequence 프로토콜을 구현하는 컬렉션은 다양한 기능을 사용할 수 있습니다.
//  - map: 데이터를 변환하다.
//  - filter: 데이터를 조건에 따라 필터한다.
// -----------
//  - sorted: 정렬된 데이터를 얻어온다.
//  - shuffled: 데이터를 랜덤으로 섞는다.

// let arr = 0..<1000  // 0..<1000 : Range
// 0...1000 : ClosedRange

// 1. lazy: 많은 데이터를 다룰 때 유용합니다.
//       - 중첩된 클로저의 연산을 한번에 처리합니다.
//       - 결과를 얻기 위해서는 순회가 필요하다.
// let arr = 0 ..< Int.max
let arr = 0 ..< Int.max

// 1000개 -> filter -> map -> suffix(3)
// -------
// 1개씩 - filter - map
// 1개씩 - filter - map
// 1개씩 - filter - map
// -------
#if false
let result = arr
  .lazy
  .filter { e -> Bool in
    e.isMultiple(of: 22)
  }
  .map { e in
    e / 11
  }
  .suffix(3)

print(result)
for e in result {
  print(e)
}

print("-------------")
#endif

// 2. reduce: 여러 요소를 통해 하나의 결과를 도출한다.
let text = """
hello
world
show
me
the
money
"""
#if false

var result = 0;
// for ... {
//   result += 1
// }

#endif

let newlineCount = text.reduce(0) { (result, char) -> Int in
  if char == "\n" {
    return result + 1
  } else {
    return result
  }
}

print(newlineCount)
