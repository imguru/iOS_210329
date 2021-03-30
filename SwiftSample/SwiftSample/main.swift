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

// class / struct / enum
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

struct DirRemover: Job {
  typealias Input = URL
  typealias Output = [String]

  func start(input: URL) -> [String] {
    do {
      var results = [String]()
      let fileManager = FileManager.default
      let fileUrls = try fileManager.contentsOfDirectory(at: input, includingPropertiesForKeys: nil)

      for file in fileUrls {
        try fileManager.removeItem(at: file)
        results.append(file.absoluteString)
      }

      return results
    } catch {
      print("Error - \(error)")
      return []
    }
  }
}

enum SendJob {
  case mail(email: String)
  case sms(phone: String)
}

extension SendJob: Job {
  typealias Input = String
  typealias Output = Bool

  func start(input: String) -> Bool {
    switch self {
    case .mail(let email):
      print("Send Mail - \(email)")
    case .sms(let phone):
      print("Send SMS - \(phone)")
    }
    return true
  }
}

// --------
// PAT 기반의 프로토콜을 사용하면, 런타임 다형성을 위한 코드를 사용할 수 없습니다.
// => 반드시 컴파일 타임 다형성을 통해 코드를 작성해야 합니다.
//  Protocol 'Job' can only be used as a generic constraint
#if false
let jobs: [Job] = [
  MailJob(),
  SendJob.mail(email: "hello@gmail.com"),
]

func runJob(job: Job) {
  // ...
}
#endif

func runJob<J: Job>(job: J, inputs: [J.Input]) {
  for input in inputs {
    _ = job.start(input: input)
  }
}

let emails = [
  "hello1@gmail.com",
  "hello2@gmail.com",
  "hello3@gmail.com",
]

runJob(job: MailJob(), inputs: emails)
runJob(job: SendJob.sms(phone: "000-111-2222"), inputs: emails)

let dirs = [
  URL(fileURLWithPath: "/Users/ourguide/Desktop/aaa") // 주의! 진짜 지워집니다.
]
runJob(job: DirRemover(), inputs: dirs)
