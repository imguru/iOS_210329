
import Foundation

let searchUrl = "https://api.github.com/search/users?q="

enum SearchResultError: Error {
  case invalidQuery(String)
  case invalidJSON
  case networkError(NetworkError)
}

typealias JSON = [String: Any]

#if false
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
    switch result {
    case let .success(data):

      if let json = try? JSONSerialization.jsonObject(with: data, options: []),
         let jsonDic = json as? JSON
      {
        completion(.success(jsonDic))
      } else {
        completion(.failure(.invalidJSON))
      }

    case let .failure(error):
      completion(.failure(.networkError(error)))
    }
  }
}
#endif

//   Array<T> -> map -> Array<U>

//   Result<SuccessT, FailureT>
//   - map / mapError
//     Result<SuccessT, FailureT>  ->  map       ->  Result<SuccessU, FailureT>  ; SuccessT -> SuccessU
//     Result<SuccessT, FailureT>  ->  mapError  ->  Result<SuccessT, FailureU>  ; FailureT -> FailureU

//   - flatMap / flatMapError
//   ; SuccessT -> Result<SuccessU, FailureT>
// Result<SuccessT, FailureT>  ->  map      -> Result<Result<SuccessU, FailureT>, FailureT>
// Result<SuccessT, FailureT>  ->  flatMap  -> Result<SuccessU, FailureT>

//   ; FailureT -> Result<SuccessT, FailureU>
// Result<SuccessT, FailureT>  -> mapError     -> Result<SuccessT, Result<SuccessT, FailureU>>
// Result<SuccessT, FailureT>  -> flatMapError -> Result<SuccessT, FailureU>
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

  getJSON(with: url) { (result: Result<Data, NetworkError>) in

    // Result<Data, NetworkError> -> xxx -> Result<JSON, SearchResultError>
    // completion(result)

    let c: Result<JSON, SearchResultError> = result            // Result<Data, NetworkError>
      .mapError { (error: NetworkError) -> SearchResultError in // Result<Data, SearchResultError>
        .networkError(error)
      }
      .flatMap { (data: Data) -> Result<JSON, SearchResultError> in

        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
           let jsonDic = json as? JSON
        {
          return .success(jsonDic)
        } else {
          return .failure(.invalidJSON)
        }
      }

    completion(c)
  }

  #if false
  getJSON(with: url) { result in
    switch result {
    // - Result<Data, NetworkError>  ->  flatMap  ->  Result<JSON, SearchResultError>
    case let .success(data):
      if let json = try? JSONSerialization.jsonObject(with: data, options: []),
         let jsonDic = json as? JSON
      {
        completion(.success(jsonDic)) // Result<JSON, SearchResultError>
      } else {
        completion(.failure(.invalidJSON)) // Result<JSON, SearchResultError>
      }

    // NetworkError -> map -> SearchResultError

    // Result
    // - Result<Data, NetworkError>  ->  mapError  ->  Result<Data, SearchResultError>
    case let .failure(error):
      completion(.failure(.networkError(error))) // Result<Data, SearchResultError>
    }
  }
  #endif
}

searchUsers(q: "apple") { result in
  switch result {
  case let .success(json):
    print(json)
  case let .failure(error):
    print(error)
  }
}

sleep(1)

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
