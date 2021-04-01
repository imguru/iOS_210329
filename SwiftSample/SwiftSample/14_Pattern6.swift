
import Foundation

#if false
protocol Validator {
  associatedtype Value

  func validate(_ value: Value) -> Bool
}

struct MinimalCountValidator: Validator {
  let minimalCount: Int

  func validate(_ value: String) -> Bool {
    return minimalCount < value.count
  }
}

struct MaximumCountValidator: Validator {
  let maxCount: Int

  func validate(_ value: String) -> Bool {
    return maxCount >= value.count
  }
}

let validator = MinimalCountValidator(minimalCount: 5)
let result = validator.validate("hello")
print(result)

let validator2 = MaximumCountValidator(maxCount: 5)
let result2 = validator2.validate("hello")
print(result2)
#endif

// Generic Struct
struct Validator<T> {
  let validate: (T) -> Bool

  init(validate: @escaping (T) -> Bool) {
    self.validate = validate
  }
}

let minValidator = Validator { (e: String) in
  e.count > 5
}

let maxValidator = Validator { (e: String) in
  e.count <= 10
}

let result = minValidator.validate("hello")
print(result)

let result2 = maxValidator.validate("hello")
print(result2)

extension Validator {
  func combine(_ other: Validator<T>) -> Validator<T> {
    return Validator { e in
      let result1 = validate(e)
      let result2 = other.validate(e)

      return result1 && result2
    }
  }
}

let v3 = minValidator.combine(maxValidator)
print(v3.validate("hellllo"))

//------------------------------------------------------------
//  가벼운 다형성                  ->       enum

//  다양한 타입의 동작이 필요하다.     ->       Generic struct / class
//  정책의 변화가 필요한 타입이 필요하다         클로저를 활용해서 만드는 방법

// 복잡한 다형성 / 기본 구현         ->       protocol

