import Foundation

// 스위프트 오류 처리
// 1. 각 에러는 상호 베타적이다. => enum이 편리합니다.
enum ParseLocationError: Error {
  case invalidData
  case network(String)
  case locationDoesNotExist
}

// 2. 오류에 추가적인 정보가 필요할 경우, class / struct 타입도 사용 가능합니다.
struct MultipleParseLocationErrors: Error {
  let parsingErrors: [ParseLocationError]
  let isShowonToUser: Bool
}

struct Location {
  let latitude: Double
  let longitude: Double
}

// 3. 스위프트에서 함수(메소드)가 오류를 던질 경우, throws 키워드를 지정해야 합니다.
//  => 어떤 종류의 오류를 던지는지 알 수 없다.
//   해결방법: 문서화를 활용해야 합니다.
//           Command + Option + /

/// 문자열로 되어 있는 위도와 경도를 Location 구조체로 만듭니다.
/// - Parameters:
///   - latitude: 위도 문자열
///   - longitude: 경도 문자열
/// - Throws: 문자열을 Double로 변경이 불가능할 경우, ParseLocationError 오류가 발생합니다.
/// - Returns: Location 구조체
func parseLocation(_ latitude: String, _ longitude: String) throws -> Location {
  guard let latitude = Double(latitude),
        let longitude = Double(longitude)
  else {
    // throw ParseLocationError.invalidData
    throw ParseLocationError.network("Host is down")
  }

  return Location(latitude: latitude, longitude: longitude)
}

// 4. throws 지정된 함수(메소드)를 호출하는 방법
//   try fn() : 예외를 외부로 전파한다.
//              전파되는 예외가 처리되지 않는다면, 프로그램은 비정상 종료한다.
//   do {} catch {}: 예외를 처리할 수 있습니다.

do {
  let location = try parseLocation("3.14x", "4.5")
  print(location)
} catch {
  print(error)
  // 5. catch 블록으로 전달되는 error는 Error의 최상위 타입입니다.
  switch error {
  case ParseLocationError.invalidData:
    print("invalidData")
  case ParseLocationError.network(let message):
    print("network - \(message)")
  case ParseLocationError.locationDoesNotExist:
    print("locationDoesNotExit")
  default:
    print("Unknown error")
  }
}

// 6. catch 에서 에러의 종류로 직접 처리하는 것도 가능합니다.
do {
  let location = try parseLocation("3.14x", "4.5")
  print(location)
} catch ParseLocationError.invalidData {
  print("invalidData")
} catch ParseLocationError.network(let message) {
  print("network - \(message)")
} catch ParseLocationError.locationDoesNotExist {
  print("locationDoesNotExit")
} catch {
  print("Unknown error")
}

func handleError(error: ParseLocationError) {
  switch error {
  case ParseLocationError.invalidData:
    print("handleError: invalidData")
  case ParseLocationError.network(let message):
    print("handleError: network - \(message)")
  case ParseLocationError.locationDoesNotExist:
    print("handleError: locationDoesNotExit")
  }
}

// 7. 에러의 타입을 기반으로 다른 처리를 하는 것도 가능합니다.
do {
  let location = try parseLocation("3.14x", "4.5")
  print(location)
} catch let error as ParseLocationError {
  print("사용자 정의 오류 - \(error)")
  handleError(error: error)
} catch {
  print("Unknown error")
}
