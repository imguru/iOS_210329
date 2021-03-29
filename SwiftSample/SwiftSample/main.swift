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

