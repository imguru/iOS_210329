import Foundation

// - 프로토콜은 제네릭에 의해 추론될 수 없다.
// - 프로토콜은 추론되는 타입이 해당 프로토콜을 만족하는 목적으로만 사용된다.

#if false
protocol Job {
  func start(input: String) -> Bool
}

class MailJob: Job {
  @discardableResult
  func start(input: String) -> Bool {
    print("MailJob start: \(input)")
    return true
  }
}

let job = MailJob()
job.start(input: "hello@gmail.com")

// _ = job.start(input: "hello@gmail.com")
#endif

// Protocols do not allow generic parameters;
// use associated types instead
// => 프로토콜은 제네릭을 타입 인자를 허용하지 않습니다.
//    PAT(Protocol Associated Type, 프로토콜 연관 타입)를 사용해야 합니다.
#if false
// protocol Job<Input, Output> {
//   func start(input: Input) -> Output
// }
#endif

protocol Job {
  associatedtype Input
  associatedtype Output
  
  func start(input: Input) -> Output
}

class MailJob: Job {
  // typealias Input = String
  // typealias Output = Bool
  
  @discardableResult
  func start(input: String) -> Bool {
    print("MailJob start: \(input)")
    return true
  }
}

let job = MailJob()
job.start(input: "hello@gmail.com")

class DirRemover : Job {
  typealias Input = URL
  typealias Output = [String]
  
  func start(input: URL) -> [String] {
      return []
  }
}
