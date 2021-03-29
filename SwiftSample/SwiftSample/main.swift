
import Foundation

// Any: 모든 객체 타입을 참조할 수 있는 타입입니다.
//  1) is - 타입 체크
//  2) as - 타입 변환

enum DataType {
  case date(Date)
  case string(String)
  case int(Int)
  case double(Double)

  // 새로운 항목이 추가되면, 컴파일러가 오류를 통해 처리해야 하는 부분을 알려줍니다.
  case intRange(Range<Int>)
  // 1...10: ClosedRange
  // 0..<10: Range

  case dateRange(Range<Date>)
}

let startDate = Date()
let endDate = Date().addingTimeInterval(10)

let arr: [DataType] = [
  .date(Date()),
  .string("Hello"),
  .int(42),
  .double(3.14),
  .intRange(1 ..< 10),
  .dateRange(startDate ..< endDate)
]

for element in arr {
  switch element {
  case let .date(date):
    print(date)
  case let .string(string):
    print(string)
  case let .int(int):
    print(int)
  case let .double(double):
    print(double)
  case let .intRange(range):
    for e in range {
      print(e)
    }
  case let .dateRange(range):
    print(range)
  }
}

#if false
let arr: [Any] = [
  Date(),
  "Hello",
  100,
  3.14,
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
#endif
