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
func parseLocation(_ latitude: String, _ longitude: String) throws -> Location {
  guard let latitude = Double(latitude),
        let longitude = Double(longitude)
  else {
    throw ParseLocationError.invalidData
  }

  return Location(latitude: latitude, longitude: longitude)
}
