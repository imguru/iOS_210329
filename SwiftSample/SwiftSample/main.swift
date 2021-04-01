
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

let controller = UIViewController()
// track의 기능을 이용하고 싶다면,
extension UIViewController: AnalyticsProtocol {}  // !!!

controller.track(event: "hello", parameters: [:])



