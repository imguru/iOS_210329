
import Foundation

// Protocol
//  - 상속(Inheritance) / 합성(Composition)

struct MailAddress {
  let value: String
}

struct Email {
  let subject: String = "Hello"
  let body: String = "Show me the money"
  let from = MailAddress(value: "hello@gmail.com")
  let to: [MailAddress] = []
}

protocol Mailer {
  func send(email: Email) throws
}

extension Mailer {
  func send(email: Email) {
    print("Mailer: mail sent - \(email)")
  }
}

protocol MailValidator {
  func validate(email: Email) throws
}

extension MailValidator {
  func validate(email: Email) {
    print("MailValidator - \(email) is valid")
  }
}

struct DefaultMailer: Mailer {}
// ----------------------------------------
// 기본 구현을 제공하려고 하는데,
// 현재의 객체 타입이 Mailer의 프로토콜도 만족하고 있는 경우만 사용하도록 하고 싶다.
extension MailValidator where Self: Mailer {
  func send(email: Email) {
    try! validate(email: email)
    print("MailValidator - send")

    DefaultMailer().send(email: email)
    // try! send(email: email)  // Mailer의 send를 호출하는 것이 아니라 재귀적으로 동작하는 문제가 있습니다.
  }

  #if false
  func sendWithValidate(email: Email) {
    try! validate(email: email)
    print("MailValidator - send")

    try! send(email: email) // Mailer의 send를 호출하는 것이 아니라 재귀적으로 동작하는 문제가 있습니다.
    // 프로토콜의 기본 구현을 다른 구현을 통해 덮을 경우, 호출할 수 있는 기능을 문법적으로 제공하지 않습니다.
    // https://forums.swift.org/t/calling-default-implementation-of-protocols/328
    //  1) 다른 이름을 사용해라
    //  2) 더미 객체를 이용한다.
  }
  #endif
}

// MailValidator / Mailer를 구현한 경우
struct SMTPClient: Mailer, MailValidator {}

let client = SMTPClient()
client.send(email: Email())
// client.sendWithValidate(email: Email())

// Mailer 프로토콜만 구현한 경우
#if false
struct SMTPClient: Mailer {}

let client = SMTPClient()
client.send(email: Email())
#endif
