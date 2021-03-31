
import Foundation

// Result
//  : 'Swift 5'의 공식적인 오류 처리에 대한 솔루션 입니다.
//  => 매우 중요합니다.

// 비동기
//  1) 동기적인 함수에서의 오류는 예외 또는 Optional를 통해서 처리할 수 있습니다.
//  2) 비동기 함수에서의 오류는 예외를 통해 처리하는 것이 불가능합니다.
//    => 별도의 스레드를 통해 통해 동작하는 비동기의 오류는 예외를 통해 전파될 수 없습니다.
//    => 오류의 인자(Error)를 콜백 함수의 마지막 인자를 통해 처리하는 것이 일반적입니다.

let url = "https://api.github.com/users/apple"

#if false
func getJSON(with url: URL) {
  let task = URLSession.shared.dataTask(with: url) { (data: Data?, _: URLResponse?, error: Error?) in
    if let error = error {
      print("Failed - \(error)")
      return
    }

    if let data = data, let value = String(data: data, encoding: .utf8) {
      print(value)
    }
  }

  // 별도의 스레드 풀에서 비동기적으로 수행됩니다.
  task.resume()
}

if let url = URL(string: url) {
  getJSON(with: url)
}
#endif

// 3. 클로저가 호출되는 시점이 함수가 종료된 이후라면, @escaping을 지정해야 합니다.
// 4. 클로저의 타입이 Optional인 경우 자동으로 @escaping입니다.
// func getJSON(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
#if false
func getJSON(with url: URL, completion: ((Data?, Error?) -> Void)? = nil) {
  let task = URLSession.shared.dataTask(with: url) { (data: Data?, _: URLResponse?, error: Error?) in
    completion?(data, error)
  }

  // 별도의 스레드 풀에서 비동기적으로 수행됩니다.
  task.resume()
}

if let url = URL(string: url) {
  getJSON(with: url) { data, error in

    if let error = error {
      print("Failed: \(error)")
    } else if let data = data {
      print("Succeed: \(data)")
    } else {
      print("????") // 이 상태는 존재하지 않습니다.
      // 해결방법: 조건문을 통해 상호 베타적인 관계를 표현하는 것이 어렵습니다.
      //         enum 기반의 Result를 이용하면 가능합니다.
    }
  }
}

sleep(1)
#endif

// Result는 enum 입니다.
// => 'Optional' 가 유사합니다.
/*
 enum Optional<Wrapped> {
   case .none
   case .some(Wrapped)
 }
 */

#if false
enum Result<Success, Failure: Error> {
  case success(Success)
  case failure(Failure)
}
#endif

enum NetworkError: Error {
  case fetchFailed(Error)
}

func getJSON(with url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
  let task = URLSession.shared.dataTask(with: url) { (data: Data?, _: URLResponse?, error: Error?) in
    
    #if false
    if let error = error {
      // completion(.failure(error))               // Result<Data, Error>
      completion(.failure(.fetchFailed(error)))    // Result<Data, NetworkError>
    } else if let data = data {
      completion(.success(data))
    }
    #endif
    
    // error: Optional<Error>   ->   map   ->   Optional<NetworkError.fetchFailed>
    #if false
    if let error = error.map( { NetworkError.fetchFailed($0) }) {
      completion(.failure(error))
    } else if let data = data {
      completion(.success(data))
    }
    #endif
    
    if let error = error.map(NetworkError.fetchFailed) {
      completion(.failure(error))
    } else if let data = data {
      completion(.success(data))
    }
    
  }

  // 별도의 스레드 풀에서 비동기적으로 수행됩니다.
  task.resume()
}

if let url = URL(string: url) {
  getJSON(with: url) { result in
    switch result {
    case let .success(data):
      print(data)
    case let .failure(error):
      print(error)
    }
  }
}
