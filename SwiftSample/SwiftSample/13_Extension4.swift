
import Foundation

class UIViewController {
  var name: String = ""
}

#if false
extension UIViewController {
  func track(event: String, parameters: [String: Any]) {
    print("UIViewController 이벤트 추적")
  }
}

// 문제점: 원하지 않는 사용자들도, UIViewController에 track 기능이 추가됩니다.
//  => 함부로 추가하지 않는 것이 좋습니다.

let controller = UIViewController()
controller.track(event: "hello", parameters: [:])
#endif

protocol AnalyticsProtocol {
  func track(event: String, parameters: [String: Any])
}

extension AnalyticsProtocol where Self: UIViewController {
  func track(event: String, parameters: [String: Any]) {
    print("UIViewController 이벤트 추적 - \(name)")
    // where Self: UIViewController - UIViewController의 공개된 속성을 이용할 수 있습니다.
  }
}

#if false
let controller = UIViewController()
// track의 기능을 이용하고 싶다면,
extension UIViewController: AnalyticsProtocol {} // !!!

controller.track(event: "hello", parameters: [:])
#endif
// ----------------------------------------------------------------

struct User : Hashable {
  let name: String
}
#if false

let arr2 = [ User(name: "Tom") ]
let result2 = arr2.unique()
print(result2)
#endif

let arr = [User(name: "Tom"), User(name: "Bob")]
let result = arr.unique()
print(result)

let arr3: Set<Int> = [ 1, 2, 3, 4, 4, 3, 2, 1 ]
let result3 = arr3.unique()
print(result3)

extension Collection where Element: Equatable {
  // O(N)
  func unique() -> [Element] {
    print("Equatable 버전")
    var uniqueValues = [Element]()

    for element in self {
      if !uniqueValues.contains(element) { // Equtable
        uniqueValues.append(element)
      }
    }

    return uniqueValues
  }
}

extension Collection where Element: Hashable {
  // O(1)
  func unique() -> [Element] {
    print("Hashable 버전")
    return Array(self)
  }
}

struct Article {
  let viewCount: Int
}

let a1 = Article(viewCount: 30)
let a2 = Article(viewCount: 300)

let articles = [ a1, a2 ]
print(articles.totalViewCount)

extension Collection where Element == Article {
  var totalViewCount: Int {
    return reduce(0) { (result, element) -> Int in
      return result + element.viewCount
    }
  }
}

// Extension에 제약을 사용함으로 써, 특정 타입에 대해서만 기능을 추가하는 것이 가능합니다.
