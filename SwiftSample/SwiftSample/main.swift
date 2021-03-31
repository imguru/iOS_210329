
import Foundation

let searchUrl = "https://api.github.com/search/users?q={keyword}"

enum SearchResultError: Error {
  case invalidQuery(String)
  case invalidJSON
  case networkError(NetworkError)
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
