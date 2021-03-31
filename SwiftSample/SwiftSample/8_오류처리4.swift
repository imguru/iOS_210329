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

func getGithubUser(login: String) throws -> User {
  if login == "root" {
    throw ApiError.client("Invalid login name").nsError
  }

  return User(login: login, company: "LG")
}

do {
  let user = try getGithubUser(login: "root")
  print(user)
} catch {
  // print(error)
  ErrorHandler.default.handle(error)
}

// 오류 처리를 중앙 집중적으로 관리하면, 오류 처리의 중복된 코드를 한곳에 모아서 관리할 수 있습니다.
// Singleton
//   - `default`
//   - shared: 생성을 불가능하게 합니다.
//             초기화 메소드를 private으로 두면 됩니다.
struct ErrorHandler {
  static let `default` = ErrorHandler()
  
  func handle(_ error: Error) {
    print(error)
  }
}



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

extension ApiError {
  var nsError: NSError {
    return NSError(apiError: self)
  }
}
