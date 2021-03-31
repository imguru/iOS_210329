import Foundation

#if false
let names = ["Tom", "Bob", "Alice"]
for name in names {
  print(name)
}

// ----------------------------
// 위의 코드는 아래와 동일한 표현입니다.
var iterator = names.makeIterator()
while let name = iterator.next() {
  print(name)
}
#endif

// Iterator Pattern(Design Pattern)
//  의도: 컨테이너(컬렉션)의 내부 구조에 상관없이 요소를 열거하는 객체

// Java
//  - Iterator
//  - Iterable

// Swift
// - IteratorProtocol
// - Sequence

class Node<Element> {
  var value: Element
  var next: Node<Element>?

  init(value: Element, next: Node<Element>?) {
    self.value = value
    self.next = next
  }
}

struct SingleList<Element> {
  var head: Node<Element>?

  mutating func append(_ element: Element) {
    head = Node(value: element, next: head)
  }

  func firstElement() -> Element? {
    return head?.value
  }
}

var list = SingleList<Int>()
list.append(10)
list.append(20)
list.append(30)

if let result = list.firstElement() {
  print(result)
}
