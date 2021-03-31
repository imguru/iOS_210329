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
#if false
public protocol IteratorProtocol {
  associatedtype Element
  mutating func next() -> Self.Element?
}
#endif

struct SingleListIterator<Element>: IteratorProtocol {
  var current: Node<Element>?

  mutating func next() -> Element? {
    defer {
      current = current?.next
    }

    return current?.value
  }

  #if false
  mutating func next() -> Element? {
    let result = current?.value
    current = current?.next
    return result
  }
  #endif
}

class Node<Element> {
  var value: Element
  var next: Node<Element>?

  init(value: Element, next: Node<Element>?) {
    self.value = value
    self.next = next
  }
}

// Sequence
#if false
public protocol Sequence {
  associatedtype Element where Self.Element == Self.Iterator.Element
  associatedtype Iterator: IteratorProtocol

  func makeIterator() -> Self.Iterator
}
#endif

struct SingleList<Element>: Sequence {
  typealias Iterator = SingleListIterator<Element>

  func makeIterator() -> SingleListIterator<Element> {
    return SingleListIterator(current: head)
  }

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

var iterator = list.makeIterator()
while let e = iterator.next() {
  print(e)
}

// Sequnce / IteratorProtocol을 만족하면 다양한 기능을 사용할 수 있습니다.
let result = list.sorted()
for e in result {
  print(e)
}

list
  .map { e in
    e * 10
  }
  .filter { e in
      return e >= 200
  }
  .forEach { e in
    print(e)
  }

#if false
if let result = list.firstElement() {
  print(result)
}
#endif
