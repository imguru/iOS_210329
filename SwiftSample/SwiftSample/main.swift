
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

// --------
let ob: Bool? = nil
if ob ?? false {
  print("true")
} else {
  print("false")
}

// ----------------
enum UserPreference: RawRepresentable {
  case enabled
  case disabled
  case notSet

  // init? -> UserPreference?
  // init  -> UserPreference
  init(rawValue: Bool?) {
    switch rawValue {
    case true?:
      self = .enabled
    case false?:
      self = .disabled
    case nil:
      self = .notSet
    }
  }

  var rawValue: Bool? {
    switch self {
    case .enabled:
      return true
    case .disabled:
      return false
    case .notSet:
      return nil
    }
  }
}

let faceIdPref = UserPreference(rawValue: preference["faceIdEnabled"])
switch faceIdPref {
case .enabled:
  print("Enabled")
case .disabled:
  print("Disabled")
case .notSet:
  print("Not set")
}

// -------------------------
// Implicitly unwrapping Optional

// Optional
//  - Int?  : Explicitly unwrapping Optional  => Optional<Int>
//  - Int!  : Implicitly unwrapping Optional  => Optional<Int>

#if false
let a: Int? = nil
// print(a)
if let a = a {
  print(a.distance(to: 10))
}

let b: Int! = nil
// print(b)
if let b = b {
  print(b.distance(to: 10))
}

func foo(_ a: Int) {
  print(a)
}

// Int? -> Int 대입은 불가능합니다.
foo(b)
#endif

class Database {
  var isConnected: Bool = false
}

class UserManager {
  #if true
  var database: Database!
  //  : 초기화가 반드시 보장되는 작업에 대해서만 사용하는 것이 안전합니다.
  
  func status() -> String {
    // Optional<Bool>?
    if database.isConnected {
      return "OK"
    } else {
      return "Database is down"
    }
  }
  #endif
  
  #if false
  var database: Database?
  func status() -> String {
    // Optional<Bool>?
    if database?.isConnected ?? false {
      return "OK"
    } else {
      return "Database is down"
    }
  }
  #endif
}

let manager = UserManager()
manager.database = Database()

print(manager.status())
