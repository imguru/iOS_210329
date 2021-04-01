
import Foundation

final class CachedValue<Element> {
  private let load: () -> Element
  private var lastLoaded: Date

  private var timeToLive: Double
  private var currentValue: Element

  var value: Element {
    let isRefresh = abs(lastLoaded.timeIntervalSinceNow) > timeToLive
    if isRefresh {
      currentValue = load()
      lastLoaded = Date()
    }

    return currentValue
  }

  init(timeToLive: Double, load: @escaping () -> Element) {
    self.timeToLive = timeToLive
    self.load = load

    currentValue = load()
    lastLoaded = Date()
  }
}

var n = 0
let cache1 = CachedValue(timeToLive: 1) { () -> Int in
  print("값이 갱신되었습니다")
  n += 1
  return n
}

let cache2 = CachedValue(timeToLive: 1) { () -> Int in
  print("값이 갱신되었습니다")
  n += 1
  return n
}

extension CachedValue: Equatable where Element: Equatable {
  static func == (lhs: CachedValue<Element>, rhs: CachedValue<Element>) -> Bool {
    return lhs.value == rhs.value
  }
}

extension CachedValue: Comparable where Element: Comparable {
  static func < (lhs: CachedValue<Element>, rhs: CachedValue<Element>) -> Bool {
    return lhs.value < rhs.value
  }
}

extension CachedValue: Hashable where Element: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}

// Equtable
if cache1 == cache2 {}

// Comparable
if cache1 < cache2 {}

// Hashable
let data: Set<CachedValue> = [
  cache1,
  cache2,
]

#if false
print(cache1.value)
print(cache1.value)
sleep(1)
print(cache1.value)
print(cache1.value)
#endif
