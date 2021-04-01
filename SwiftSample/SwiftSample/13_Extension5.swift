
import Foundation

protocol Base {
  // func foo() - 명세가 존재하는 경우: 동적 바인딩
               // 명세가 존재하지 않을 경우: 정적 바인딩
}

extension Base {
  func foo() {
    print("Base foo")
  }
}

struct Derivied: Base {
  func foo() {
    print("Dervied foo")
  }
}

// 정적 바인딩: 참조 타입에 기반해서 함수를 호출한다. - 컴파일 타임
// 동적 바인딩(디스패치): 실제 참조하고 있는 객체의 타입에 기반해서 함수를 호출한다. - 실행 시간
let p: Base = Derivied()
p.foo()

