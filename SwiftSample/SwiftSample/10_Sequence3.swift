
import Foundation

// 아래의 컬렉션에서 반복자를 구현해봅시다.
// 1. 직접 반복자를 구현하는 방법

struct BagIterator<Element: Hashable>: IteratorProtocol {
  var store = [Element: Int]()

  mutating func next() -> Element? {
    guard let (key, value) = store.first else {
      return nil
    }

    if value > 1 {
      store[key]? -= 1
    } else {
      store[key] = nil
    }

    return key
  }
}

extension Bag: Sequence {
  func makeIterator() -> BagIterator<Element> {
    return BagIterator(store: store)
  }
}


// 1. 요소의 빈도를 관리할 수 있는 Bag 구조체를 만들어봅시다.
struct Bag<Element: Hashable> {
  // private var store: [Element: Int] = [:]
  private var store = [Element: Int]()

  mutating func insert(_ element: Element) {
    store[element, default: 0] += 1
  }

  mutating func remove(_ element: Element) {
    store[element, default: 0] -= 1

    if store[element] == 0 {
      store[element] = nil
    }
  }

  var count: Int {
    return store.values.reduce(0, +)
  }
}

let text = """
hello, world
show me the money
"""

var bag = Bag<Character>()
for e in text {
  bag.insert(e)
}

print(bag.count)
print(bag)

for e in bag {
  print(e)
}
