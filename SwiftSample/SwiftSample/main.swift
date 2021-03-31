
import Foundation

//                  Sequence
//                      |
//                  Collection
//                      |
//   -------------------------------------------
//   |
// MutableCollection

// 1) MutableCollection
//   : 길이를 변경하지 않고 요소를 값을 변경할 수 있는 연산을 제공한다.
//    - sort
var arr = [ 1, 3, 5, 7, 9, 2, 4, 6, 8, 10 ]
arr.sort()
print(arr)

let index = arr.partition { e -> Bool in
  e % 2 == 0
}
// print(index)
let result1 = arr[..<index]
let result2 = arr[index...]

print(result1)
print(result2)





#if false
public protocol Collection: Sequence {
  associatedtype Element
  associatedtype Index

  var startIndex: Self.Index { get }
  var endIndex: Self.Index { get } // 끝 다음 인덱스

  subscript(position: Self.Index) -> Self.Element { get }

  func index(after i: Int) -> Self.Index
}
#endif

#if false
struct Fruits {
  let banana = "Banana"
  let apple = "Apple"
  let tomato = "Tomato"
}

extension Fruits: Collection {
  typealias Element = String
  typealias Index = Int

  var startIndex: Int {
    return 0
  }

  var endIndex: Int {
    return 3
  }

  subscript(position: Int) -> String {
    switch position {
    case 0: return banana
    case 1: return apple
    case 2: return tomato
    default:
      fatalError("Out of index")
    }
  }

  func index(after i: Int) -> Int {
    return i + 1
  }
}

// Collection은 Sequence를 만족합니다.
let fruits = Fruits()
for e in fruits {
  print(e)
}
let result = fruits.map { e in
  e.uppercased()
}
print(result)

let result2 = fruits.sorted()
print(result2)
#endif
