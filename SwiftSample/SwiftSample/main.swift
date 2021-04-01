import Foundation

// Extension
//  - 상속: 수직 확장
//       - 런타임 다형성을 제공하고, '부모 클래스에 기본 구현'을 제공할 수 있습니다.
//       - 부모 클래스와 자식 클래스의 강한 결합이 형성되기 때문에, 유지보수에 어려움이 생길 수 있다.
//  - Extension: 수평 확장
//       - 상속을 이용하지 않고 새로운 기능을 추가할 수 있다.
//       - 프로토콜이나 추가적인 관계를 형성하는 것도 가능합니다.
protocol RequestBuilder {
  var baseURL: URL { get }

  func makeRequest(path: String) -> URLRequest
}

#if false
struct GithubRequestBuilder: RequestBuilder {
  let baseURL = URL(string: "https://api.github.com")!

  func makeRequest(path: String) -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.httpShouldHandleCookies = false
    request.timeoutInterval = 3
    return request
  }
}

struct NaverRequestBuilder: RequestBuilder {
  let baseURL = URL(string: "https://api.naver.com")!

  func makeRequest(path: String) -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.httpShouldHandleCookies = false
    request.timeoutInterval = 3
    return request
  }
}
#endif

// 1. 프로토콜에 기본 구현을 제공하기 위해서는 반드시 'extension'을 이용해야 합니다.
extension RequestBuilder {
  func makeRequest(path: String) -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.httpShouldHandleCookies = false
    request.timeoutInterval = 3
    return request
  }
}

struct GithubRequestBuilder: RequestBuilder {
  let baseURL = URL(string: "https://api.github.com")!
}

struct NaverRequestBuilder: RequestBuilder {
  let baseURL = URL(string: "https://api.naver.com")!
}

let requestBuilder = GithubRequestBuilder()
let request = requestBuilder.makeRequest(path: "/users")
print(request)

