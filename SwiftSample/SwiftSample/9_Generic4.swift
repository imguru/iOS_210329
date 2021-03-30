
import Foundation

#if true
class Car {
  func go() {
    print("Car go")
  }
}

class Truck: Car {
  override func go() {
    print("Truck go")
  }
}

// 부모의 타입을 통해 자식 객체를 참조할 수 있습니다.
//  => 암묵적인 Upcasting을 허용합니다.
let car: Car = Truck()
car.go()
#endif



//   Car
//    |
//  Truck

// Optional<Int> : Int?
//     |
//    Int        : Int
let a: Int? = 40


// Optional<Car>
//      |
// Optional<Truck>

// Optional<Car>
//     |
//   Truck

// 1. 표준 라이브러리에서 제공하는 제네릭 타입은 '공변적'이다. - covarint
 let truck1: Optional<Truck> = Truck()
 let truck2: Truck? = Truck()
 let truck3: Car? = Truck()

// 2. 사용자가 제공하는 제네릭은 '공변적'이지 않습니다. - invarint
struct Container<T> {}
// let truck: Container<Car> = Container<Truck>()  // error!

let arr: [Car] = [
  Truck(),
  Truck(),
]

let dic: [String: Any] = [
  "name": "Tom",  // [String: String]
  "age": 42,      // [String: Int]
]











