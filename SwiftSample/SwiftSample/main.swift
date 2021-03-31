
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

// Optional<String> -> map -> Optional<Optional<URL>>
let url = path.map { URL(string: $0) }
print(type(of: url))

let url2 = path.flatMap { URL(string: $0) }
print(type(of: url2))

// --------------

let strings = [
  "https://naver.com",
  "https://daum.net",
  " ",
  "https://facebook.com",
]

// compactMap
let urls = strings.compactMap {
  URL(string: $0) // init?(...)
}
print(urls)


#if false
let urls: [URL] = strings.map {
  URL(string: $0) // init?(...)
}.filter {
  $0 != nil
}.map {
  $0!
}
print(urls)
#endif



