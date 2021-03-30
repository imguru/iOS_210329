
import Foundation

// 정렬된 값을 출력하고, 값의 빈도를 출력합니다.
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
