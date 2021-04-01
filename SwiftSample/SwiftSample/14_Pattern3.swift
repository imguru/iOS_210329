
import Foundation

// Conditional Comformance(조건부 순응)

struct Actor: Equatable {}

// 구조체 내부의 모든 속성이 Equtable을 만족하면, Movie도 Equtable을 자동으로 제공한다.
struct Movie: Equatable {
  let title: String
  let rating: Float
  let actor: Actor? = nil

  init(title: String, rating: Float) {
    self.title = title
    self.rating = rating
  }

  func play() {
    print("Movie play - \(title)/\(rating)")
  }

  #if false
  static func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.title == rhs.title && lhs.rating == rhs.rating
  }
  #endif
}


let movie1 = Movie(title: "타이타닉", rating: 4.9)
let movie2 = Movie(title: "타이타닉2", rating: 4.1)

// Movie는 동등성 비교를 위한 Equtable을 만족(순응)해야 한다.
if movie1 == movie2 {
  print("같은 영화입니다")
}

//------

let movies = [ movie1, movie2 ]

#if false
for e in movies {
  e.play()
}
#endif

protocol Playable {
  func play()
}

extension Movie: Playable {}

// let arr = [ 1, 2, 3, 4 ]
movies.play()

extension Array: Playable where Element: Playable {
  func play() {
    for e in self {
      e.play()
    }
  }
}

func playDelayed<T: Playable>(_ movie: T, delay: Double) {
  print("After delay: \(delay)")
  movie.play()
}

#if false
let movie3 = Movie(title: "Hello", rating: 1.0)
playDelayed(movie3, delay: 3.0)
#endif

let movie3: Movie? = Movie(title: "Hello", rating: 1.0)
if let movie = movie3 {
  playDelayed(movie, delay: 3.0)
}

movie3.play()
extension Optional: Playable where Wrapped: Playable {
  func play() {
    print("Optional play")
    switch self {
    case let value?:
      value.play()
    case nil:
      break
    }
  }
}
