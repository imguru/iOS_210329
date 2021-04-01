
import Foundation

// Protocol
//  - 상속(Inheritance) / 합성(Composition)

struct MailAddress {
  let value: String
}

struct Email {
  let subject: String
  let body: String
  let from: MailAddress
  let to: [MailAddress]
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

//----------------------------------------
// 기본 구현을 제공하려고 하는데,
// 현재의 객체 타입이 Mailer의 프로토콜도 만족하고 있는 경우만 사용하도록 하고 싶다.

extension MailValidator where Self: Mailer {
  func send(email: Email) throws {
    try validate(email: email)
    print("MailValidator - send")
  }
}

struct SMTPClient: Mailer, MailValidator {
}

let client = SMTPClient()
try client.send(email: Email(subject: "Hello", body: "...", from: MailAddress(value: "hello@gmail.com"), to: []))




