import Foundation

// static vs class
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
  // print("Truck foo")
  // }
}

let truck = Truck()
Car.foo()
Truck.foo()
#endif

// self: class의 인스턴스의 self
// Self: class의 Self

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
