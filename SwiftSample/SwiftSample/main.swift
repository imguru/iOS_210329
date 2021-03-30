
import Foundation

// 정렬된 값을 출력하고, 값의 빈도를 출력합니다.
#if false
func printValues(_ values: [String]) {
  print(values.sorted())

  var result = [String: Int]()
  for e in values {
    let v = result[e] ?? 0
    result[e] = v + 1
  }

  print(result)
}

let arr = [
  "hello",
  "world",
  "hello",
  "world",
  "hello",
  "world",
  "show",
  "me",
]
printValues(arr)
#endif

// 제약 사항이 여러 개 존재할 경우,
//  T: Comparable & Hashable
#if false
func printValues<T: Comparable & Hashable>(_ values: [T]) {
  print(values.sorted()) // Comparable

  var result = [T: Int]() // Hashable
  for e in values {
    let v = result[e] ?? 0
    result[e] = v + 1
  }

  print(result)
}
#endif
func printValues<T>(_ values: [T])
  where T: Comparable & Hashable
{
  print(values.sorted()) // Comparable

  var result = [T: Int]() // Hashable
  for e in values {
    let v = result[e] ?? 0
    result[e] = v + 1
  }

  print(result)
}

let arr = [
  "hello",
  "world",
  "hello",
  "world",
  "hello",
  "world",
  "show",
  "me",
]
printValues(arr)
