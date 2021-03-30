
import Foundation

enum Membership {
  case silver
  case gold
}

let m: Membership? = Membership.gold
// silver
// gold
// nil
switch m {
case .silver?:
  print("silver")
case .gold?:
  print("gold")
case nil:
  print("nil")
}

#if false
if let m = m {
  switch m {
  case .silver:
    print("silver")
  case .gold:
    print("gold")
  }
} else {
  print("nil")
}
#endif
