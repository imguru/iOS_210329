import Foundation

// Optional / Nullable
//  => nil을 안전하게 다루는 기능
struct User {
  let id: Int
  let email: String

  let name: String? // Optional<String>
  // let name: Optional<String>

  let address: String? = "Suwon"
}

let user = User(id: 0, email: "hello@gmail.com", name: "Tom")

// 1) enum을 통해서 Optional이 구현되어 있습니다.
/*
 enum Optional<Wrapped> {
   case none
   case some(Wrapped)
 }
 */

/*
 switch user.name {
 case .some(let value):
   print("some - \(value)")
 case .none:
   print("none - nil")
 }
 */

switch user.name {
case let value?:
  print("some - \(value)")
case nil:
  print("none - nil")
}

/*
 if let name = user.name {
   if let address = user.address {
       print("User: \(name) - \(address)")
   }
 }
 */

// 동시에 두 개 이상의 Optional을 처리하는 것도 가능합니다.
// - Optional Binding
if let name = user.name,
   let address = user.address
{
  print("User: \(name) - \(address)")
}

if let _ = user.name {
  print("이름이 입력되어 있습니다")
}

if user.name != nil {
  print("이름이 입력되어 있습니다")
}

if let name = user.name, !name.isEmpty {
  print("이름이 제대로 입력되어 있습니다")
}

class Person: CustomStringConvertible {
  let email: String
  let name: String

  init(email: String, name: String) {
    self.email = email
    self.name = name
  }

  // CustomStringConvertible 프로토콜을 만족하면, 사용자가 원하는 형태로 변환이 가능합니다.
  var description: String {
    return "Person(email=\(email), name=\(name))"
  }
}

// struct: User(id: 0, email: "hello@gmail.com", name: Optional("Tom"), address: Optional("Suwon"))
print(user)
// dump(user)

// dump - 내부의 속성 값을 확인하는데 유용하다.
let person = Person(email: "hello@gmail.com", name: "Bob")
// print(person)
print(person)

extension User: CustomStringConvertible {
  var description: String {
    var result = "User(email=\(email)"

    // 스위프트에서 Optional Binding을 할 때, 기존의 이름을 덮어쓰는 것이 일반적입니다.
    if let name = name {
      result += ", name=\(name)"
    }

    // if let unwrappedName = name {
    //  result += ", name=\(unwrappedName)"
    // }

    result += ")"

    return result
  }
}
