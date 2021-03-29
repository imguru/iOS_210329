
import Foundation

// Any: 모든 객체 타입을 참조할 수 있는 타입입니다.
//  1) is - 타입 체크
//  2) as - 타입 변환

let arr: [Any] = [
  Date(),
  "Hello",
  100,
  3.14
]

for element in arr {
  switch element {
  case let v as Date:
    print("Date - \(v)")
  case let v as String:
    print("String - \(v)")
  case let v as Int:
    print("Int - \(v)")
  case let v as Double:
    print("Double - \(v)")
  default:
    print("Unsupported Type")
  }
  
  
  #if false
  switch element {
  case is Date:
    print("Date")
  case is String:
    print("String")
  case is Int:
    print("Int")
  case is Double:
    print("Double")
  default:
    print("Unsupported Type!")
  }
  #endif
}
