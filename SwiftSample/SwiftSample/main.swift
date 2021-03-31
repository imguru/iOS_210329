
import Foundation

// (String) -> String
func removeEmojis(_ text: String) -> String {
  var scalars = text.unicodeScalars
  scalars.removeAll { e in
    e.properties.isEmoji
  }

  return String(scalars)
}

// Emoji: Command + Ctrl + Space
let message: String? = "Hello,😘🤬 wo😘🤬rl🍅d sh😘🤬ow m🍅e t😘🤬he m😘🤬oney"
if let message = message {
  let result = removeEmojis(message)
  print(result)
}

// [ T ]            -> map  -> [ U ]
// Optional<T>      -> map  -> Optional<U>

// message: String? -> map ->

#if false
let result = message.map { message in
  removeEmojis(message)
}

if let result = result {
  print(result)
}
#endif

#if false
if let result = message.map { removeEmojis($0) } {
  print(result)
}
#endif

#if false
if let result = message.map({ removeEmojis($0) }) {
  print(result)
}


// // (String) -> String
if let result = message.map(removeEmojis) {
  print(result)
}
#endif

// print(result)

#if false
let message = "Hello,😘🤬 wo😘🤬rl🍅d sh😘🤬ow m🍅e t😘🤬he m😘🤬oney"
let result = removeEmojis(message)

print(result)
#endif

func filter(_ data: [Int], predicate: (Int) -> Bool) -> [Int] {
  var result = [Int]()
  for e in data where predicate(e) {
    result.append(e)
  }
  return result
}

let arr = [ 1, 3, 5, 7, 9, 2, 4, 6, 8, 10 ]
var result2 = filter(arr, predicate: { e -> Bool in
  e.isMultiple(of: 3)
})

// 스위프트의 함수의 타입은 시그니처에 의해 결정된다.
// '함수의 시그니처'는 함수의 인자와 반환 타입에 의해서 결정된다.
// (Int) -> Bool
func isMultiple3(_ value: Int) -> Bool {
  return value.isMultiple(of: 3)
}

// Trailing Closure: 함수의 마지막 인자가 함수라면, 함수 블록을 함수 호출 괄호 밖으로 둘 수 있다.
result2 = filter(arr) { e -> Bool in
  isMultiple3(e)
}

result2 = filter(arr, predicate: isMultiple3)

print(result2)

// (Int, Int) -> Int
func add(a: Int, b: Int) -> Int {
  return a + b
}

func sub(a: Int, b: Int) -> Int {
  return a - b
}

let mul = { (a: Int, b: Int) -> Int in
  a * b
}

var fn: (Int, Int) -> Int = add
fn = sub
fn = mul

let result3 = fn(10, 20)
print(result3)

//---------
struct User {
  let age: Int
  
  // add의 시그니처는 무엇인가요?
  // - 메소드는 연관된 객체가 존재한다.
  // - thiscall: 암묵적으로 메소드의 첫번째 인자로 객체의 주소가 전달된다.
  
  // (User, Int, Int) -> Int
  //-------
  // (Int, Int) -> Int
  //  let user = User()
  //  user.add(10, 20)
  //  user.add
  
  func add(a: Int, b: Int) -> Int {
    print("User::add")
    return a + b
  }
  
  func foo(a: Int) -> Bool {
    return a.isMultiple(of: 3)
  }
}

let user = User(age: 100)
// let result = user.add(a: 10, b: 20)  // add(self: user, a: 10, b: 20)

fn = user.add      // Bound reference: 객체가 결정되어 있다.
let result = fn(10, 20)
print(result)


//                     (Int) -> Bool
result2 = filter(arr, predicate: user.foo)
print(result2)






