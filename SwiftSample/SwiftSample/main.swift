import Foundation

// enum

// 채팅 메세지
//  1. 일반적인 텍스트 메세지
//  2. 채팅 참가 메세지
//  3. 채팅 탈퇴 메세지

#if false
struct Message {
  let userId: Int
  let contents: String?
  let date: Date

  let hasJoined: Bool
  let hasLeft: Bool
}

let joinMessage = Message(userId: 1, contents: nil, date: Date(), hasJoined: true, hasLeft: false)
let textMessage = Message(userId: 1, contents: "Hello", date: Date(), hasJoined: false, hasLeft: false)
let leftMessage = Message(userId: 1, contents: nil, date: Date(), hasJoined: false, hasLeft: true)

// 문제점: 잘못된 상태의 객체가 만들어질 수 있습니다.
let wrongMessage = Message(userId: 1, contents: "Hi", date: Date(), hasJoined: true, hasLeft: true)
#endif

// 해결 방법 - enum
//  - '상호 베타적'인 관계를 표현할 수 있습니다.
//  - 연관 값(튜플)을 이용하면, 데이터도 포함할 수 있습니다.

enum Message {
  case text(userId: Int, contents: String, date: Date)
  case join(userId: Int, date: Date)
  case leave(userId: Int, date: Date)

  // case xxx
}

let joinMessage = Message.join(userId: 1, date: Date())
let textMessage = Message.text(userId: 1, contents: "Hello", date: Date())
let leaveMessage: Message = .leave(userId: 1, date: Date())

func logMessage(message: Message) {
  // 모든 경우를 처리하는 형태로 만들어 놓는 것이 좋다.
  // => 새로운 case가 추가되었을 경우, 컴파일 오류가 발생한다.
  #if false
  switch message {
  case .text(userId: let userId, contents: let contents, date: let date):
    print("Text - \(userId) / \(contents) / \(date)")
  case .join(userId: let userId, date: let date):
    print("Join - \(userId) / \(date)")
  case .leave(userId: let userId, date: let date):
    print("Leave - \(userId) / \(date)")
  }
  #endif

  #if false
  switch message {
  case .text(let userId, let contents, let date):
    print("Text - \(userId) / \(contents) / \(date)")
  case .join(let userId, let date):
    print("Join - \(userId) / \(date)")
  case .leave(let userId, let date):
    print("Leave - \(userId) / \(date)")
  }
  #endif
  
  switch message {
  case let .text(userId, contents, date):
    print("Text - \(userId) / \(contents) / \(date)")
  case let .join(userId, date):
    print("Join - \(userId) / \(date)")
  case let .leave(userId, date):
    print("Leave - \(userId) / \(date)")
  }
}

logMessage(message: joinMessage)
logMessage(message: textMessage)
logMessage(message: leaveMessage)
