
import Foundation

#if false
enum MyError: Error {
  // case가 없습니다. - 절대 실패하지 않는다.
}

func load(url: String, completion: (Result<String, MyError>) -> Void) {}

load(url: "https://a.com") { result in
  switch result {
  case let .success(data):
    print(data)
    // Failure를 만들지 않아도, 컴파일 오류가 발생하지 않습니다.
  }
}
#endif

func load(url: String, completion: (Result<String, Never>) -> Void) {}

// Never 용도: Never는 객체 생성이 불가능한 타입입니다.
// - 함수의 반환이 발생하지 않는다.
func foo() -> Never {
    fatalError("xxx")
}

load(url: "https://a.com") { result in
  switch result {
  case let .success(data):
    print(data)
    // Failure를 만들지 않아도, 컴파일 오류가 발생하지 않습니다.
  }
}

