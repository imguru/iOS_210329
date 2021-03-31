
import Foundation

// 아래의 컬렉션에서 반복자를 구현해봅시다.
// 2. AnyIterator를 이용하는 방법(Boxing)
#if false
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
#endif

extension Bag: Sequence {
  func makeIterator() -> AnyIterator<Element> {
    // init(store: ...)
    var store = self.store
    
    // next() 로직을 클로저를 통해 전달합니다.
    return AnyIterator {
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
}

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
