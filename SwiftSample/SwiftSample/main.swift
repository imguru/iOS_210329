
import Foundation

// 다형성
//  - 상속
#if false
class Displayble {
  func display() {}
}

class User: Displayble {
  override func display() {
    print("User display")
  }
}

class Car: Displayble {
  override func display() {
    print("Car display")
  }
}

let arr: [Displayble] = [
  User(),
  Car(),
]
for e in arr {
  e.display()
}
#endif

// Duck(오리) Typing 설계
//  => 동일한 행위를 가지고 있는 객체를 대상으로 다형성을 구현할 수 있다.
//  - Javasciprt / Ruby / Python
//  문제점: 해당 기능을 제공하지 않을 경우 런타임에 오류가 발생한다.
//
//  스위프트는 protocol / extension을 통해서 해당 기능을 안전하게 구현할 수 있습니다.

class User {
  func display() {
    print("User display")
  }
}

struct Car {
  func display() {
    print("Car display")
  }
}

enum Hello {
  case morning
  
//  func display() {
//    print("Hello display")
//  }
}


//-------
protocol Displayable {
  func display()
}

extension User: Displayable {}
extension Car: Displayable {}
extension Hello: Displayable {
  func display() {
    print("Hello display")
  }
}

let arr: [Displayable] = [ User(), Car(), Hello.morning ]
for e in arr {
  e.display()
}
