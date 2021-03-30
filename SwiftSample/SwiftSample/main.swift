
import Foundation

enum ApiError: Error {
  case network(String)
  case client(String)
  case server
}

struct User {
  let login: String
  let company: String
}

extension ApiError {
  var nsError: NSError {
    return NSError(apiError: self)
  }
}


func getGithubUser(login: String) throws -> User {
  if login == "root" {
    // throw ApiError.client("Invalid login name")
    // throw NSError(domain: "MyDomain", code: 100, userInfo: ["hello":"Tom"])
    
    // throw NSError(apiError: ApiError.client("Invalid login name"))
    throw ApiError.client("Invalid login name").nsError
  }

  return User(login: login, company: "LG")
}

do {
  let user = try getGithubUser(login: "root")
  print(user)
} catch let error as NSError {
  // NSError: Obj-C에서 다루는 Error 타입
  //  => NSError 가 출력되는 형식을 변경해야 합니다.
  print(error)
}

/// A localized message describing what error occurred.
// var errorDescription: String? { get }

// 1. 오류를 출력할 때 추가적인 정보를 제공할 수 있습니다.
extension ApiError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .network(let message):
      return "errorDescription: network(\(message))"
    case .client(let message):
      return "errorDescription: client(\(message))"
    case .server:
      return "errorDescription: server"
    }
  }

  var failureReason: String? {
    switch self {
    case .network:
      return "failureReason: 네트워크 오류 입니다"
    case .client:
      return "failureReason: 클라이언트가 잘못했습니다."
    case .server:
      return "failureReason: 서버가 잘못했습니다."
    }
  }

  var recoverySuggestion: String? {
    return "재부팅하세요"
  }
}

// 2. NSError가 출력되는 형식을 지정할 수 있습니다.
extension ApiError: CustomNSError {
  static var errorDomain: String {
    return "ApiError"
  }

  var errorCode: Int {
    switch self {
    case .network:
      return 100
    case .client:
      return 400
    case .server:
      return 500
    }
  }

  var errorUserInfo: [String: Any] {
    return [
      NSLocalizedDescriptionKey: errorDescription ?? "",
      NSLocalizedFailureErrorKey: failureReason ?? "",
      NSLocalizedRecoverySuggestionErrorKey: recoverySuggestion ?? ""
    ]
  }
}

// -----
extension NSError {
  convenience init(apiError: ApiError) {
    self.init(domain: ApiError.errorDomain, code: apiError.errorCode, userInfo: apiError.errorUserInfo)
  }
}
