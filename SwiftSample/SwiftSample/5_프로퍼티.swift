import Foundation

// 프로퍼티
//  => 접근자 메소드를 자동으로 생성하는 기술
//   let - getter
//   var - getter / setter
//  1) Stored Property - 저장형 프로퍼티
//  2) Computed Property - 계산형 프로퍼티
//    => 프로퍼티를 가장한 메소드 입니다.
//       간단한 메소드를 계산형 프로퍼티로 사용하면, 코드의 가독성에 도움이 됩니다.

// class Timer {} - reference type
//  let t1 = Timer()
//  var t1 = Timer()
//   let/var
//    [t1] -------> [  Timer  ]

// struct Timer {}  - value type (enum)
//  let t1 = Timer()
//  var t1 = Timer()

//    let/var
//    [  t1   ]

#if false
struct Timer {
  let id: Int
  let startTime: Date
  var endTime: Date?
  
  func elapsedTime() -> TimeInterval {
    return Date().timeIntervalSince(startTime)
  }
  
  func isFinished() -> Bool {
    return endTime != nil
  }
  
  // 내부의 속성을 변경하는 메소드는 반드시 mutating으로 지정되어야 합니다.
  // var timer = Timer()
  //  => 가변 객체
  //     mutating method를 호출할 수 있습니다.
  // let timer = Timer()
  //  => 불변 객체: 객체가 생성된 이후에 내부의 속성이 변경되지 않는다.
  //     mutating method를 호출할 수 없습니다.
  mutating func setFinished() {
    endTime = Date()
  }
  
  // 사용자가 원하는 형태로 객체를 초기화하기 위해서는 별도의 초기화를 제공해야 합니다.
  //  => 구조체가 자동으로 제공하는 초기화 메소느는 사라집니다.
  init(id: Int, startTime: Date) {
    self.id = id
    self.startTime = startTime
  }
}

// let timer = Timer(id: 1, startTime: Date(), endTime: nil) - error!
// let timer = Timer(id: 1, startTime: Date())
var timer = Timer(id: 1, startTime: Date())
print(timer.elapsedTime())
sleep(2)
print(timer.elapsedTime())
timer.setFinished()
print(timer.isFinished())
#endif


struct Timer {
  let id: Int
  let startTime: Date
  var endTime: Date?
  
  // Computed Property - var
  #if false
  var elapsedTime: TimeInterval {
    get {
      return Date().timeIntervalSince(startTime)
    }
  }
  #endif
  // Getter 만 제공하는 경우에는 좀더 간단하게 표현할 수 있습니다.
  var elapsedTime: TimeInterval {
      return Date().timeIntervalSince(startTime)
  }
  
  var isFinished: Bool {
    get {
      return endTime != nil
    }
    
    // timer.isFinished = true
    // let timer = Timer(...)
    // timer.isFinished = true  // compile error!
    
    // var timer = Timer()
    // timer.isFinished = true  // compile ok!
    set {
      // newValue: 사용자가 전달한 값
      if newValue {
        endTime = Date()
      } else {
        endTime = nil
      }
    }
  }
  
  init(id: Int, startTime: Date) {
    self.id = id
    self.startTime = startTime
  }
}

var timer = Timer(id: 1, startTime: Date())
print(timer.elapsedTime)
sleep(2)
print(timer.elapsedTime)

timer.isFinished = true // 구조체의 경우 var 에서만 수행 가능합니다.
print(timer.isFinished)

//--------
class User {
  var name: String = "Tom"
  var age: Int = 42
}

// var user = User()
let user = User()
user.age = 100
user.name = "Bob"
