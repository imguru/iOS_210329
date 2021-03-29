
import Foundation

enum Membership {
  case gold
  case silver
  // case bronze
}

struct User {
  let membership: Membership?
}

let user = User(membership: nil)
if let membership = user.membership {
  switch membership {
  case .gold:
    print("10% 할인")
  case .silver:
    print("5% 할인")
  }
} else {
  print("0% 할인")
}

// 위의 코드를 간결하게 표현하는 방법
//  주의사항: default를 사용하면, 컴파일러가 새로운 항목이 추가되어도 오류를 주지 않습니다.
switch user.membership {
case .gold?:
  print("10% 할인")
case .silver?:
  print("5% 할인")
case nil:
  // default:
  print("0% 할인")
}

// Dictionary<String, Bool>
let preference: [String: Bool] = [
  "autoLogin": true,
  // "isFaceIdEnabled": false,
]

if let autoLogin = preference["autoLogin"] {
  print(autoLogin)
}

// Optional<Bool>
//  => true / false / nil
if let isFaceIdEnabled = preference["isFaceIdEnabled"], isFaceIdEnabled {
  print("페이스아이디활성화: \(isFaceIdEnabled)")
} else {
  print("페이스아이디비활성화")
}

// ?? true: 존재하지 않을 경우, true 로직으로 동작합니다.
if preference["isFaceIdEnabled"] ?? true {
  print("페이스아이디활성화")
} else {
  print("페이스아이디비활성화")
}




