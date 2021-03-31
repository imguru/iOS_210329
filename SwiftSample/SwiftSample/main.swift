
import Foundation

// map
//  Sequence / Optional
// -----------------------------
//   Array<A>       Array<B>
//    [ A ]  -> map -> [ B ]

//  Optional<A>     Optional<B>
//      A?  -> map ->  B?

let suits = ["Hearts", "Clubs", "Diamonds", "Spades"]
let faces = ["2", "3", "4" ]
// let faces = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

// Array<String> -> map -> Array<Array<Tuple>>

let deck = suits.map { suit in  
  faces.map { face in
    (suit, face)
  }
}

print(deck)
