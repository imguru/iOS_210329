import Foundation

// Optional / Nullable
//  => nil을 안전하게 다루는 기능
struct User {
  let id: Int
  let email: String
  
  let name: String?  // Optional<String>
  // let name: Optional<String>
}

let user = User(id: 0, email: "hello@gmail.com", name: nil)

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
