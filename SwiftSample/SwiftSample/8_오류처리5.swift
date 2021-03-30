import Foundation

enum UserError: Error {
  case emptyValueNotAllowed
  case invalidEmail
}

struct User {
  let email: String
  
  // 타입을 생성할 때 유효성을 미리 검증할 수 있다면, 이후의 오류 처리를 줄일 수 있습니다.
  // - 실패의 원인이 2개 이상인 경우, 오류(예외)를 던지는 것이 좋습니다.
  #if true
  init(email: String) throws {
    if email.isEmpty {
      throw UserError.emptyValueNotAllowed
    }
    
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    if email.range(of: pattern, options: .regularExpression, range: nil, locale: nil) == nil {
      throw UserError.invalidEmail
    }
    
    self.email = email
  }
  #endif
  
  // 오류의 원인이 1개 라면, 예외 보다는 Optional이 편리합니다.
  #if false
  init?(email: String) {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    if email.range(of: pattern, options: .regularExpression, range: nil, locale: nil) == nil {
      return nil  // !!!
    }
    
    self.email = email
  }
  #endif
}

// init?()
#if false
if let user = User(email: "hello@") {
  print(user)
} else {
  print("생성 실패")
}
#endif

// throws
// 1. try  - 외부로 전파(do - catch)
// 2. try! - 오류(예외)발생시 프로그램 종료
// 3. try?
if let user = try? User(email: "hello@") {
  print(user)
} else {
  print("생성 실패")
}

// init(..) throws
#if false
do {
  let user = try User(email: "")
  print(user)
} catch {
  print(error)
}

do {
  let user = try User(email: "@a.com")
  print(user)
} catch {
  print(error)
}
#endif
