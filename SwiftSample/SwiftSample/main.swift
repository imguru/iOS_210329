
import Foundation

enum Membership {
  case gold
  case silver
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
switch user.membership {
case .gold?:
  print("10% 할인")
case .silver?:
  print("5% 할인")
case nil:
  print("0% 할인")
}


