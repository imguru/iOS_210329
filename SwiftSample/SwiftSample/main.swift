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

class Sedan: Car {}

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
// print(car1)
// print(car2)

// 4. class 타입은 초기화 메소드를 반드시 제공해야 합니다.
//   => 저장 프로퍼티에 대한 초기화가 반드시 필요합니다.
class CarMarket {
  let cars: [Car]
  let capacity: Int

  // 5. 모든 프로퍼티를 온전하게 초기화하는 초기화메소드를 '지정 초기화 메소드'라고 합니다.
  //    파라미터의 기본 값을 지정하면, 불필요한 오버로딩을 방지할 수 있습니다.
  // init(cars: [Car], capacity: Int = 100) {

  required init(cars: [Car], capacity: Int = 100) {
    self.cars = cars
    self.capacity = capacity
  }

  // 6. 다른 종류의 초기값을 통해 초기화가 필요한 경우, 초기화 메소드를 오버로딩 하면 됩니다.
  convenience init(names: [String]) {
    var cars = [Car]()
    for name in names {
      cars.append(Car(name: name))
    }

    // self.cars = cars
    // self.capacity = 100

    // 직접 초기화 하는 것이 아니라, 기존의 초기화 메소드를 통해 초기화를 수행할 경우,
    // convenience 키워드를 지정해야 합니다.
    //  => 편의 초기화 메소드(편의 생성자)
    self.init(cars: cars)
  }

  // 9.
  // 정적 팩토리 메소드 - static factory method
  // - 문제점: 자식 클래스도 반드시 아래의 create 함수를 제공해야 합니다.
  #if false
  class func create(cars: [Car]) -> CarMarket {
    return CarMarket(cars: cars)
  }
  #endif

  // 아래의 함수가 모든 자식 클래스에서 제대로 동작하기 위해서는
  // 정적 팩토리 메소드 안에서 호출하는 초기화 메소드가 모든 자식 클래스에서 반드시 구현되어야 한다.
  // => 스위프트에서는 자식 클래스 반드시 제공해야 하는 초기화 메소드에 대해서 required 를 지정하면 됩니다.
  class func create(cars: [Car]) -> Self {
    return self.init(cars: cars)
  }
}

let market1 = CarMarket(cars: [], capacity: 100)
let market2 = CarMarket(cars: [])
let market3 = CarMarket(names: [
  "Sonata", "K5",
])

class OnlineCarMarket: CarMarket {
//  override class func create(cars: [Car]) -> OnlineCarMarket {
//    return OnlineCarMarket(cars: cars)
//  }

  let url: String

  init(cars: [Car], capacity: Int, url: String) {
    self.url = url

    super.init(cars: cars, capacity: capacity)
  }

  // 8. 부모가 제공하는 초기화 메소드를 이용하고 싶다면,
  //    부모의 지정 초기화 메소드를 오버라이딩 해야 합니다.
  // override convenience init(cars: [Car], capacity: Int = 100) {

  // 부모의 required 초기화 메소드는 override가 아닌 required 이어야 한다.
  required convenience init(cars: [Car], capacity: Int = 100) {
    self.init(cars: cars, capacity: capacity, url: "https://a.com/cars")
  }
}

// 7.
// 자식 클래스가 초기화 메소드를 제공하고 있지 않은 경우
// => 부모의 초기화 메소드와, 편의 초기화 메소드를 상속 받습니다.

// 자식 클래스가 직접 초기화 메소드를 제공하면, 부모의 초기화 메소드와 편의 초기화 메소드를 사용할 수 없습니다.

let omarket1 = OnlineCarMarket(cars: [], capacity: 100, url: "https://a.com/cars")

let omarket2 = OnlineCarMarket(cars: [])
let omarket3 = OnlineCarMarket(cars: [], capacity: 100)
let omarket4 = OnlineCarMarket(names: [
  "Sonata", "K5",
])

// 정적 팩토리 메소드(static factory method)
// 1. 가독성
//   - 객체 생성에 대한 방법을 다양한 이름을 통해 제공할 수 있습니다.
// 2. 객체 생성의 정책을 유연하게 변경할 수 있습니다.
let market = CarMarket.create(cars: [])
let omarket = OnlineCarMarket.create(cars: [])

// dump(market)
// dump(omarket)

// required
// 1) 클래스 팩토리 메소드(= 정적 팩토리 메소드)
//   => 클래스 팩토리 내부에서 호출되는 초기화 메소드
// 2) 프로토콜
//   => 상속 가능한 클래스에서 초기화메소드를 제공할 경우, 반드시 required를 통해 제공해야 합니다.
//   => 상속 불가능한 final 클래스에서는 required 키워드를 생략할 수 있습니다.

protocol UserType {
  var name: String { get set }
  
  init(address: String)
  
  func display()
}

// final class: 상속 금지 클래스
final class User: UserType {
  init(address: String) {
    
  }
  
  // var name: String = "Tom"
  var name: String {
    get {
      return "Tom"
    }
    set {
      
    }
  }
  
  func display() {
    print("User display")
  }
}
