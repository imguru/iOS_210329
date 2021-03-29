import Foundation

// Optional / Nullable
//  => nil을 안전하게 다루는 기능
struct User {
  let id: Int
  let email: String
  
  let name: String?  // Optional<String>
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
   let address = user.address {
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

