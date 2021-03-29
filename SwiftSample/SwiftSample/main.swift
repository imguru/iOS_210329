import Foundation

// Tuple - 다양한 값의 묶음
//  => 임시적으로 사용할 때는 유용하지만, 범용적으로 사용될 경우 구조체나 클래스를 이용해야 한다.

func foo() -> (String, Int) {
  return ("Tom", 42)
}

var result = foo()
print("\(result.0) / \(result.1)")

var (name, age) = foo()
print("\(name) / \(age)")

//---------

func foo2() -> (name: String, age: Int) {
  return (name: "Tom", age: 42)
}

var result2 = foo2()
print("\(result2.name) / \(result2.age)")

var (name2, age2) = foo2()
print("\(name2) / \(age2)")

//---------

typealias UserTuple = (name: String, age: Int, isAdmin: Bool)

func foo3() -> UserTuple {
  return (name: "Tom", age: 42, isAdmin: false)
}

var (name3, _, isAdmin) = foo3()
print("\(name3) / \(isAdmin)")






