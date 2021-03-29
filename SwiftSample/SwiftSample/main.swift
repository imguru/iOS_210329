import Foundation

// static vs class
// => class 키워드를 통해 오버라이딩 가능한 정적 메소드 / 정적 프로퍼티를 제공할 수 있습니다.
#if false
class Car {
  // static func foo() {
  //  print("Car foo")
  // }

  class func foo() {
    print("Car foo")
  }
}

class Truck: Car {
  override class func foo() {
    print("Truck foo")
  }

  // 자식 클래스가 동일한 이름의 static method를 제공하는 것이 불가능합니다.
  // static func foo() {
  //   print("Truck foo")
  // }
}

let truck = Truck()
Car.foo()
Truck.foo()
#endif

// self: class의 인스턴스의 self
// Self: class의 Self
//      => 자기 자신의 동적 클래스
//         타입에 대한 정보를 실행시간에 동적으로 접근할 수 있다.

class Car {
  class var name: String {
    return "\(Self.self)"
  }
}

class Truck: Car {
//  override class var name: String {
//      return "Truck"
//  }
}

class Sedan: Car {
}

print(Truck.name)
print(Sedan.name)
