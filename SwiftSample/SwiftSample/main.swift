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

#if false
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
#endif

// enum이 제공하는 모든 case를 배열로 얻어올 수 있게 하는 프로토콜이 있습니다. - CaseIterable
enum Color: CaseIterable {
  case red, blue, white, crayon
}

#if false
struct Car {
  let name: String
  let color: Color
  
  init(name: String) {
    self.name = name
    self.color = Color.allCases.randomElement()!
    // randomElement: case가 아무것도 존재하지 않을 경우, nil을 반환합니다.
  }
}
#endif

// 1. 구조체는 자동으로 각 프로퍼티를 초기화하는 메소드를 제공합니다.
// 2. 사용자 정의 초기화 메소드를 제공할 경우, 멤버 와이즈 초기화 메소드는 더 이상 제공되지 않습니다.

// 3. 사용자 정의 초기화메소드가 필요하고, 컴파일러가 생성하는 멤버 와이즈 초기화 메소드도 필요한 경우
//   => 사용자 정의 초기화 메소드를 extension을 통해 제공하면 됩니다.
struct Car {
  let name: String
  let color: Color
}
 
extension Car {
  init(name: String) {
    self.name = name
    self.color = Color.allCases.randomElement()!
  }
}

let car1 = Car(name: "Sonata", color: .white)
let car2 = Car(name: "K5")

print(car1)
print(car2)


