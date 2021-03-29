import Foundation

// 중복된 속성이 존재합니다.
// => 객체 지향 설계에서는 중복된 속성을 부모 클래스를 통해 캡슐화가 가능합니다.
// => 스위프트에서 상속을 사용하기 위해서는 구조체가 아닌 클래스를 이용해야 합니다.
#if false
struct User {
  let email: String
  let password: String
  let joinDate: Date
  
  var level: Int
  var exp: Int
}

struct Admin {
  let email: String
  let password: String
  let joinDate: Date
  
  var logs: [String]
}
#endif

// 클래스
// - 구조체와 다르게 멤버 초기화 메소드가 자동으로 제공되지 않습니다.
// - 사용자는 프로퍼티의 초기값을 지정하거나, 초기화 메소드를 통해 초기화를 수행해주어야 합니다.

// 상속의 문제점 - 경직된 설계
// 1. 새로운 Account 기반 타입을 도입할 때, 기존에 설계한 구조와 다를 경우 전체적인 구조에 대한 변경이 어렵습니다.
//  Guest
//   - joinDate
//   - level
//   - exp
// 2. 상속을 이용하기 위해서는 참조 타입인 class를 이용해야 합니다.

#if false
class Account {
  let email: String
  let password: String
  let joinDate: Date
  
  init(email: String, password: String, joinDate: Date) {
    self.email = email
    self.password = password
    self.joinDate = joinDate
  }
  
  func display() {
    print("Account display")
  }
}

class User: Account {
  var level: Int
  var exp: Int
  
  // 자신의 속성을 먼저 초기화 하고, 부모의 지정 초기화 메소드를 통해 초기화를 수행해야 합니다.
  init(email: String, password: String, joinDate: Date, level: Int, exp: Int) {
    self.level = level
    self.exp = exp
    
    super.init(email: email, password: password, joinDate: joinDate)
  }
  
  override func display() {
    print("User display")
  }
}

class Admin: Account {
  var logs: [String]
  
  init(email: String, password: String, joinDate: Date, logs: [String]) {
    self.logs = logs
    
    super.init(email: email, password: password, joinDate: joinDate)
  }
  
  override func display() {
    print("Admin display")
  }
}

let arr: [Account] = [
  User(email: "hello@gmail.com", password: "linux123", joinDate: Date(), level: 1, exp: 1000),
  Admin(email: "ok@gmail.com", password: "linux123", joinDate: Date(), logs: [])
]

// 상속을 이용해서 구현하는 다형성
for e in arr {
  e.display()
}

#endif

#if false
class Account {
  let joinDate: Date
  
  init(joinDate: Date) {
    self.joinDate = joinDate
  }
  
  func display() {
    print("Account display")
  }
}

class User: Account {
  let email: String
  let password: String
  var level: Int
  var exp: Int
  
  // 자신의 속성을 먼저 초기화 하고, 부모의 지정 초기화 메소드를 통해 초기화를 수행해야 합니다.
  init(email: String, password: String, joinDate: Date, level: Int, exp: Int) {
    self.email = email
    self.password = password
    self.level = level
    self.exp = exp
    
    super.init(joinDate: joinDate)
  }
  
  override func display() {
    print("User display")
  }
}

class Admin: Account {
  let email: String
  let password: String
  var logs: [String]
  
  init(email: String, password: String, joinDate: Date, logs: [String]) {
    self.email = email
    self.password = password
    self.logs = logs
    
    super.init(joinDate: joinDate)
  }
  
  override func display() {
    print("Admin display")
  }
}

class Guest: Account {
  var level: Int
  var exp: Int
  
  init(joinDate: Date, level: Int, exp: Int) {
    self.level = level
    self.exp = exp
    
    super.init(joinDate: joinDate)
  }
  
  override func display() {
    print("Guest display")
  }
}

let arr: [Account] = [
  User(email: "hello@gmail.com", password: "linux123", joinDate: Date(), level: 1, exp: 1000),
  Admin(email: "ok@gmail.com", password: "linux123", joinDate: Date(), logs: []),
  Guest(joinDate: Date(), level: 0, exp: 1000)
]

// 상속을 이용해서 구현하는 다형성
for e in arr {
  e.display()
}
#endif

// enum을 통해서 상속의 관계를 표현하는 방법
//  장점
//  1. 새로운 유형을 추가할 때, 기존 코드 구조적인 변경이 필요하지 않습니다.
//  2. 구조체를 활용할 수 있습니다.

//  단점
//  1. enum을 사용하면 중복된 항목을 별도로 캡슐화하는 것이 어렵습니다.
//  2. 다형성을 구현하기 위해서는 직접 분기의 코드를 작성해야 합니다.

struct User {
  let email: String
  let password: String
  let joinDate: Date
  
  var level: Int
  var exp: Int
}

struct Admin {
  let email: String
  let password: String
  let joinDate: Date
  
  var logs: [String]
}

struct Guest {
  let joinDate: Date
  var level: Int
  var exp: Int
}

#if false
enum Account {
  case user(User)
  case admin(Admin)
  case guest(Guest)
  
  func display() {
    switch self {
    case let .user(user):
      print("User display - \(user)")
    case let .admin(admin):
      print("Admin display - \(admin)")
    case let .guest(guest):
      print("Guest display - \(guest)")
    }
  }
}
#endif
enum Account {
  case user(User)
  case admin(Admin)
  case guest(Guest)
}

extension Account {
  func display() {
    switch self {
    case let .user(user):
      print("User display - \(user)")
    case let .admin(admin):
      print("Admin display - \(admin)")
    case let .guest(guest):
      print("Guest display - \(guest)")
    }
  }
}


let arr: [Account] = [
  .user(User(email: "hello@gmail.com", password: "linux123", joinDate: Date(), level: 1, exp: 1000)),
  .admin(Admin(email: "admin@gmail.com", password: "linux123", joinDate: Date(), logs: [])),
  .guest(Guest(joinDate: Date(), level: 1, exp: 1000))
]

for e in arr {
   e.display()
}
