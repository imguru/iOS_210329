
import Foundation

// 프로퍼티 관찰자
//  => KVO(Key-Value Observation)
// : Stored Property(저장 프로퍼티)의 값이 변경될 때 수행되는 블록을 지정할 수 있습니다.

// didSet
//  - 값이 변경된 이후에 호출되는 블록입니다.
//  - oldValue
//  - 값의 변경 이후로 추가적으로 수행해야 하는 작업이 있을 경우 사용합니다.

// willSet
//  - 값이 변경되기 이전에 호출되는 블록입니다.
//  - newValue
//  - 속성이 변경될 것이라는 사실을 외부에 알릴 때 많이 사용합니다.
struct User {
  var email: String {
    didSet {
      print("didSet - \(oldValue)")

      // didSet / willSet이 호출되지 않습니다.
      email = email.lowercased().trimmingCharacters(in: .whitespaces)

      // if oldValue.hasPrefix("hello") {
      //  email = oldValue
      // }
    }

    willSet {
      print("willSet - \(newValue)")
    }
  }

  init(email: String) {
    print("init begin")
    self.email = email

    // defer: 함수가 종료된 후에 호출되는 블록을 지정합니다.
    //        함수의 마지막에 수행되어야 하는 정리코드는 캡슐화하는 목적으로 사용합니다.
    defer {
      print("defer()")
      self.email = email
    }

    print("init end")
  }
}

// 주의사항: 초기화메소드를 통해서 설정된 값에 대해서는 didSet / willSet이 동작하지 않습니다.
var user = User(email: "     hello@gmail.com     ")

// user.email = "   world@gmail.com    "
print(user.email)
