import Foundation

//------------------------------------------
// https://github.com/onevcat/Kingfisher/blob/master/Sources/General/Kingfisher.swift
public struct KingfisherWrapper<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

// protocol KingfisherCompatible: AnyObject {}
// - Reference type(class / ObjC class)에 대해서만 해당 프로토콜을 이용할 수 있습니다.

protocol KingfisherCompatible {}
extension KingfisherCompatible {
  // 정적 바인딩
  public var kf: KingfisherWrapper<Self> {
    get { return KingfisherWrapper(self) }
    set {}
  }
}

// class
extension UIButton: KingfisherCompatible { }

// struct
extension UIImage: KingfisherCompatible { }

// class / protocol
extension KingfisherWrapper where Base: UIButton {
  func display() {
    print("UIButton KF display - \(base.name)")
  }
}

// struct / enum
extension KingfisherWrapper where Base == UIImage {
  func drawImage() {
    print("UIImage draw - \(base.imageName)/\(base.imageSize)")
  }
}

//---------------------------------------------
struct UIImage {
  var imageName: String = "profile.jpg"
  var imageSize: CGSize = CGSize(width: 100, height: 100)
}

let image = UIImage()
image.kf.drawImage()

class UIButton {
  var name: String = "UIButton"
}
let button = UIButton()
button.kf.display()


