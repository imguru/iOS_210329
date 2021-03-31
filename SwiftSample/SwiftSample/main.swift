
import Foundation

let searchUrl = "https://api.github.com/search/users?q="

enum SearchResultError: Error {
  case invalidQuery(String)
  case invalidJSON
  case networkError(NetworkError)
}

typealias JSON = [String: Any]

func searchUsers(q: String, completion: @escaping (Result<JSON, SearchResultError>) -> Void) {
  let encodedQuery = q.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // String?

  // String? -> map -> String?
  let path = encodedQuery.map {
    searchUrl + $0
  }

  guard let url = path.flatMap(URL.init) else {
    completion(.failure(.invalidQuery(q)))
    return
  }

  getJSON(with: url) { result in
    // ...
  }
}

// ----------------------------
// 이전 소스 참조
enum NetworkError: Error {
  case fetchFailed(Error)
}

func getJSON(with url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
  let task = URLSession.shared.dataTask(with: url) { (data: Data?, _: URLResponse?, error: Error?) in
    if let error = error.map(NetworkError.fetchFailed) {
      completion(.failure(error))
    } else if let data = data {
      completion(.success(data))
    }
  }

  task.resume()
}
