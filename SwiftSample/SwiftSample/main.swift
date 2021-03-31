
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

func getJSON(with url: URL) {
  let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      print("complete")
  }

  // 별도의 스레드 풀에서 비동기적으로 수행됩니다.
  task.resume()
}

if let url = URL(string: url) {
  getJSON(with: url)
}

sleep(1)


