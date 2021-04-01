import Foundation

//------------------------------------------
public struct KingfisherWrapper<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

protocol KingfisherCompatible: AnyObject {}
extension KingfisherCompatible {
  public var kf: KingfisherWrapper<Self> {
    get { return KingfisherWrapper(self) }
    set {}
  }
}

extension UIButton: KingfisherCompatible { }
extension KingfisherWrapper {
  func display() {
      print("UIButton KF display")
  }
}

//---------------------------------------------

@objc class UIButton: NSObject {
  var name: String = "UIButton"
}
let button = UIButton()
button.kf.display()


