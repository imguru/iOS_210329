
import Foundation

// Sequence 프로토콜을 구현하는 컬렉션은 다양한 기능을 사용할 수 있습니다.
//  - map: 데이터를 변환하다.
//  - sorted: 정렬된 데이터를 얻어온다.
//  - filter: 데이터를 조건에 따라 필터한다.
//  - shuffled: 데이터를 랜덤으로 섞는다.

let arr = 0..<1000  // 0..<1000 : Range
                    // 0...1000 : ClosedRange

let result = arr
  .filter { e -> Bool in
    e.isMultiple(of: 22)
  }
  .map { e in
    return e / 11
  }
  .shuffled()

print(result)
