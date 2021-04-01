
import Foundation

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
}

struct GithubAPI {
  let session: URLSession

  init(session: URLSession) {
    self.session = session
  }

  func getJSON(completion: @escaping (Result<Data, Error>) -> Void) {
    let url = URL(string: "https://api.github.com/users/apple")!

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
