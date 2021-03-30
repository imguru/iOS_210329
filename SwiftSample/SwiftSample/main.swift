import Foundation

// Protocol
//  => Protocol Oriented Programming(POP)
//  1) 런타임 프로토콜: 인터페이스 기반 프로그래밍
//  2)

protocol Country {
  var name: String { get }
  var exchangeRate: Float { get set }
}

struct Korea: Country {
  let name = "Korea"
  var exchangeRate: Float = 1200
}

struct America: Country {
  let name = "America"
  var exchangeRate: Float = 1
}



#if false
class World {
  var countries: [Country]

  init(countries: [Country]) {
    self.countries = countries
  }

  func addCountry(_ country: Country) {
    countries.append(country)
  }

  func process() {
    for country in countries {
      print("\(country.name) - \(country.exchangeRate)")
    }
  }
}

let countries: [Country] = [
  Korea(),
  America(),
]

let world = World(countries: countries)
world.process()

print(type(of: world))
print(type(of: world.countries))
#endif

// Generic
//  아래 버전의 문제점
//   => 결국 코드를 생성하기 때문에, C의 타입이 하나의 구체적인 타입으로 결정된다.
class World<C: Country> {
  var countries: [C]
  
  init(countries: [C]) {
    self.countries = countries
  }
  
  func addCountry(_ country: C) {
    countries.append(country)
  }
  
  func process() {
    for country in countries {
      print("\(country.name) - \(country.exchangeRate)")
    }
  }
}

// 1. 스위프트의 클래스의 타입 인자는 초기화 메소드의 인자 타입을 통해 추론 가능합니다.
// 2. 제네릭 타입 인자의 제약은 타입 추론과 관계 없다.
// 3. 제약을 사용하는 타입 인자로 프로토콜 타입을 전달할 수 없습니다.

let countries = [
  Korea(),
  Korea(),
  Korea(),
  Korea(),
]

// -> Array<Korea>
let world = World(countries: countries) // C -> Korea
world.process()
print(type(of: world))
print(type(of: world.countries))

let countries2 = [
  America(),
]
let world2 = World(countries: countries2) // C -> Korea
world2.process()
print(type(of: world2))
print(type(of: world2.countries))




#if false
let countries: [Country] = [
  Korea(),
  America(),
]
let world = World(countries: countries)
world.process()
#endif
