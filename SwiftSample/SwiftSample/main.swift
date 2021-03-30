
import Foundation

// Generic
//  - 스위프트에서는 제네릭에 대해서 정확하게 이해하는 것이 중요합니다.
//  - 오버로딩: 다른 타입에 인자를 받는 동일한 이름의 함수를 제공할 수 있습니다.
//            "다형성"
//  - 제네릭을 이용하면 타입은 다르지만, 동일한 로직을 갖고 있는 함수에 대해서 중복을 제거할 수 있다.
//  - 한번만 만들면 되고, 아직 작성되지 않은 다양한 타입에 대해서도 대응이 가능하다.
//  - Any를 사용하지 않기 때문에, 실행 시간에 다운 캐스트 같은 불필요한 동작이 필요하지 않습니다.

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

struct User {
  let name: String
}

let arr3 = [
  User(name: "Tom"),
  User(name: "Bob"),
]

let result3 = firstAndLast(arr3)
print("\(result3.0) / \(result3.1)")




#if false
// Java에서는 타입 인자는 Object 타입으로 컴파일 됩니다.
// => Generic에 원시 타입(int, double, char)을 저장할 수 없습니다.
// => Boxing / Wrapper class(Integer, Double, Char)

// ArrayList<Integer> arr = new ArrayList<>();
// arr.add(10);
// arr.add(20);
// add.add("hello");  // Compile error O

// ArrayList arr = new ArrayList();
// arr.add(Integer.valueOf(10));
// arr.add(Integer.valueOf(20));
// add.add("hello");  // Compile error X
#endif
