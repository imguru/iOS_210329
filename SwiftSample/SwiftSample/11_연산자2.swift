
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
let message: String? = "Hello,ππ€¬ woππ€¬rlπd shππ€¬ow mπe tππ€¬he mππ€¬oney"
if let message = message {
  let result = removeEmojis(message)
  print(result)
}

// [ T ]            -> map  -> [ U ]
// Optional<T>      -> map  -> Optional<U>

// message: String? -> map ->

#if false
let result: String? = message.map { message in
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
let message = "Hello,ππ€¬ woππ€¬rlπd shππ€¬ow mπe tππ€¬he mππ€¬oney"
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

let arr = [1, 3, 5, 7, 9, 2, 4, 6, 8, 10]
var result2 = filter(arr, predicate: { e -> Bool in
  e.isMultiple(of: 3)
})

// μ€μννΈμ ν¨μμ νμμ μκ·Έλμ²μ μν΄ κ²°μ λλ€.
// 'ν¨μμ μκ·Έλμ²'λ ν¨μμ μΈμμ λ°ν νμμ μν΄μ κ²°μ λλ€.
// (Int) -> Bool
func isMultiple3(_ value: Int) -> Bool {
  return value.isMultiple(of: 3)
}

// Trailing Closure: ν¨μμ λ§μ§λ§ μΈμκ° ν¨μλΌλ©΄, ν¨μ λΈλ‘μ ν¨μ νΈμΆ κ΄νΈ λ°μΌλ‘ λ μ μλ€.
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

// ---------
struct User {
  let age: Int

  // addμ μκ·Έλμ²λ λ¬΄μμΈκ°μ?
  // - λ©μλλ μ°κ΄λ κ°μ²΄κ° μ‘΄μ¬νλ€.
  // - thiscall: μλ¬΅μ μΌλ‘ λ©μλμ μ²«λ²μ§Έ μΈμλ‘ κ°μ²΄μ μ£Όμκ° μ λ¬λλ€.

  // (User, Int, Int) -> Int    : C++ / Kotlin
  // (User) -> (Int, Int) -> Int : Swift - μ»€λ§(μ§μ° νΈμΆ)
  
  // -------
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

fn = user.add // Bound reference: κ°μ²΄κ° κ²°μ λμ΄ μλ€.
let result = fn(10, 20)
print(result)

//                     (Int) -> Bool
result2 = filter(arr, predicate: user.foo)
print(result2)

// Optional - map(transform)

// Int? -> map -> String?
let a: Int? = 100
#if false
let s: String? = a.map { a in
  String(a)
}
#endif

if let s = a.map(String.init) {
  print(s)
}

let x = User.add
print(type(of: x))

// (User) -> (Int, Int) -> Int
//  : ν¨μμ μκ·Έλμ²λ₯Ό νννλ -> λ μ°κ²°ν© ν©λλ€.
//  => Userμ νμμ μΈμλ‘ λ°μμ Int μΈμλ₯Ό 2κ°λ₯Ό λ°κ³  Intλ₯Ό λ°ννλ ν¨μλ₯Ό λ°ννλ ν¨μ
let add = x(user) //
let r = add(10, 20)
print(r)

// let r = x(user)(10, 20)
// print(r)
