
import Foundation

// JSON
// {
//    "avatarUrl": "xxx"   // Default
//    "avatar_url": "xxx"  // convertFromSnakeCase
// }

// Swift - "Dependency Injection"
//       => Testability - 테스트 용이성

#if false
struct User: Decodable, Encodable {
  let login: String
  let id: Int
  let avatarUrl: String
}
#endif

struct User: Codable {
  let login: String
  let id: Int
  let avatarUrl: String
  let company: String?
}

#if false
struct GithubAPI {
  let session: URLSession

  init(session: URLSession) {
    self.session = session
  }

  func getJSON(completion: @escaping (Result<Data, Error>) -> Void) {
    let url = URL(string: "https://api.github.com/users/JakeWharton")!

    let task = session.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data {
        completion(.success(data))
      } else {
        fatalError()
      }
    }
    task.resume()
  }
}

let api = GithubAPI(session: URLSession.shared)
api.getJSON { result in
  switch result {
  case let .success(data):
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    if let user = try? decoder.decode(User.self, from: data) {
      print(user)
    } else {
      print("JSON decoding failed")
    }

  case let .failure(error):
    print(error)
  }
}

sleep(1)
#endif

protocol DataTask {
  func resume()
}

protocol Session {
  associatedtype Task: DataTask

  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task
}

struct GithubAPI<S: Session> {
  let session: S

  init(session: S) {
    self.session = session
  }

  func getJSON(completion: @escaping (Result<Data, Error>) -> Void) {
    let url = URL(string: "https://api.github.com/users/JakeWharton")!

    let task = session.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data {
        completion(.success(data))
      } else {
        fatalError()
      }
    }
    task.resume()
  }
}

extension URLSession: Session {}
extension URLSessionDataTask: DataTask {}

// Test를 위한 Session을 제공하자.
struct TestTask: DataTask {
  let completion: (Data?, URLResponse?, Error?) -> Void

  func resume() {
    let testData = User(login: "test_login", id: 0, avatarUrl: "", company: nil)

    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase

    let data = try! encoder.encode(testData)
    completion(data, nil, nil)
  }
}

struct TestSession: Session {
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TestTask {
    return TestTask(completion: completionHandler)
  }
}

#if true
// let api = GithubAPI(session: URLSession.shared)
let api = GithubAPI(session: TestSession())


api.getJSON { result in
  switch result {
  case let .success(data):
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    if let user = try? decoder.decode(User.self, from: data) {
      print(user)
    } else {
      print("JSON decoding failed")
    }

  case let .failure(error):
    print(error)
  }
}

sleep(1)
#endif
