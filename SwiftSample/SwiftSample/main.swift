
import Foundation

// Generic
//  - 스위프트에서는 제네릭에 대해서 정확하게 이해하는 것이 중요합니다.
//  - 오버로딩: 다른 타입에 인자를 받는 동일한 이름의 함수를 제공할 수 있습니다.
//            "다형성"
//  - 제네릭을 이용하면 타입은 다르지만, 동일한 로직을 갖고 있는 함수에 대해서 중복을 제거할 수 있다.
//  - 한번만 만들면 되고, 아직 작성되지 않은 다양한 타입에 대해서도 대응이 가능하다.

// 'Generic'을 구현하는 방식
//  => C++, C#, Java, Kotlin
// 1) 컴파일러가 코드를 생성한다.
//  => C++, C#, Swift
//   : 타입 안정성 뿐 아니라, '컴파일 타임 다형성'을 구현하는 것이 가능하다.

// 2) Any 타입으로 생성하고, 컴파일러는 타입 체크만을 수행한다.
//  => Java, Kotlin
//   : 타입 안정성을 위해서 사용한다.

#if false
func firstAndLast(_ array: [Int]) -> (Int, Int) {
  return (array[0], array[array.count - 1])
}

func firstAndLast(_ array: [String]) -> (String, String) {
  return (array[0], array[array.count - 1])
}
#endif

func firstAndLast<T>(_ array: [T]) -> (T, T) {
  return (array[0], array[array.count - 1])
}

let arr = [1, 2, 3, 4, 5]
let result = firstAndLast(arr)

print("\(result.0) / \(result.1)")

let arr2 = ["Apple", "Banana", "Orange"]
let result2 = firstAndLast(arr2)

print("\(result2.0) / \(result2.1)")
