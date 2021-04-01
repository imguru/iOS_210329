
import Foundation



// Protocol 'Game' can only be used as a generic constraint because it has Self or associated type requirements
// => Hashable이 상속하는 Equatable의 프로토콜이 내부적으로 Self를 사용하고 있기 때문에
//    런타임 다형성을 사용할 수 없습니다.
#if false
protocol Game: Hashable {
  func start()
}

struct VideoGame: Game {
  func start() {
    print("VideoGame start")
  }
}

struct PCGame: Game {
  func start() {
    print("PCGame start")
  }
}


let numberOfPlayers: [Game: Int] = [
  VideoGame(): 40,
  PCGame(): 100,
]
#endif

#if false
let arr: [Game] = [
  VideoGame(),
  PCGame()
]

for e in arr {
  e.start()
}
#endif

// 해결 방법
// 1) enum을 사용하자
//   => enum은 struct와 동일하게 '조건부 순응'을 제공합니다.

enum Game: Hashable {
  case video(VideoGame)
  case pc(PCGame)
}

struct VideoGame: Hashable {
  func start() {
    print("VideoGame start")
  }
}

struct PCGame: Hashable {
  func start() {
    print("PCGame start")
  }
}

let numberOfPlayers: [Game: Int] = [
  .video(VideoGame()): 40,
  .pc(PCGame()): 100,
]
