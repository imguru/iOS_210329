
import Foundation

// 1. Swift 특징
//  1) 고성능
//  2) 함수형 프로그래밍
//  3) 프로토콜 지향 프로그래밍 - POP(Protocol Oriented Programming)
//    => PAT(프로코톨 연관 타입)
//  4) 강력한 컴파일 타임 언어

// 2. Swift 단점
//  1) 모듈 호환성
//     - 최신 스위프트의 버전이 나오면 이전 버전과 호환성이 떨어집니다.
//    2014: 1.0
//    2015: 2.0
//    2016: 3.0
//    2017: 4.0
//    2018: 5.0
//      19: 5.1
//      20: 5.2
//      21: 5.3

//  2) 엄격한 타입 체크
//    - 다른 언어에 비해 상대적으로 엄격하다.

//  3) 프로토콜 난해
//    - Equtable
#if false
func areAllEquals(value: Equatable, values: [Equatable]) -> Bool {
  // ...
  return true
}
#endif

// 4) 동시성 지원
//    - 언어적으로 지원되는 기능이 없습니다. ('코루틴'이 없습니다)
//    - GCD(Grand Central Dispatch) / Reative Extension(RxSwift)

// 5) Apple Platform에 종속적이다.
//    - 스위프트는 리눅스 기반에서도 이용할 수 있지만, 지원하는 패키지의 개수가 적다.

// 6) 컴파일 시간
//    - LLVM 기반 컴파일러를 이용함으로써, 정적 분석 등의 유용한 기능을 제공하지만
//      컴파일 프로세스 시간이 오래 걸린다.
print("Hello, World!")
