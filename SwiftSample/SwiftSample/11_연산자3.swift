
import Foundation

// map
//  Sequence / Optional
// -----------------------------
//   Array<A>       Array<B>
//    [ A ]  -> map -> [ B ]

//  Optional<A>     Optional<B>
//      A?  -> map ->  B?

let suits = ["Hearts", "Clubs", "Diamonds", "Spades"]
// let faces = ["2", "3", "4" ]
let faces = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

// Array<String> -> map        -> Array<Array<Tuple>>

#if false
// Array<String> -> map -> Array<Array<(String, String)>>
let deck = suits.map { suit in
  faces.map { face in
    (suit, face)
  }
}
#endif

//                 flatten
// Array<String> -> flatMap    -> Array<Tuple>
let deck = suits.flatMap { suit in
  faces.map { face in
    (suit, face)
  }
}

// print(deck)
let info = [
  "url": "https://api.github.com/users",
]

let path: String? = info["url"]
// String -> URL


// String -> Optional<URL>
// Optional<String> -> map -> Optional<Optional<URL>>
let url = path.map { URL(string: $0) }
print(type(of: url))

// Optional<String> -> flatMap -> Optional<URL>
let url2 = path.flatMap { URL(string: $0) }
print(type(of: url2))

// --------------

let strings = [
  "https://naver.com",
  "https://daum.net",
  " ",
  "https://facebook.com",
]

// - 예전 이름이 flatMap 이었습니다. : deprecated

// compactMap: Optional의 결과에서 nil을 제거하고, 실제 Wrapped 타입으로 결과를 변환합니다.

#if false
let urls = strings.compactMap {
  URL(string: $0) // init?(...)
}
print(urls)

let urls: [URL] = strings.map {
  URL(string: $0) // init?(...)
}.filter {
  $0 != nil
}.map {
  $0!
}
print(urls)
#endif


let urls: [URL?] = strings.map {
  URL(string: $0) // init?(...)
}

// 방법 1.
for url in urls {
  guard let url = url else {
    continue
  }
  
  print(url)
}

// 방법 2.
for case let .some(url) in urls {
  print(url)
}

// 방법 3. 가장 좋은 방법
for case let url? in urls {
   print(url)
}
