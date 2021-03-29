
import Foundation

struct UIImage {
  let url: String
}

#if false
struct Image {
  let url: String

  // 시간이 오래 걸리는 작업은 계산형 프로퍼티는 적합하지 않습니다.
  var image: UIImage {
    print("Download image from \(url)")
    sleep(1)

    return UIImage(url: url)
  }

  func draw() {
    print("Draw image - \(image)")
  }
}
#endif

struct Image {
  let url: String

  // 시간이 오래 걸리는 작업은 계산형 프로퍼티는 적합하지 않습니다.
  // => 지연 초기화(lazy initialization)
  // var
  //  - getter
  //  - setter: private - 객체 내부에서만 값을 변경하도록 하고 싶다.
  private(set) lazy var image: UIImage = {
    print("Download image from \(url)")
    sleep(1)

    return UIImage(url: url)
  }()

  #if false
  lazy var image: UIImage = loadImageFromUrl()
  private func loadImageFromUrl() -> UIImage {
    print("Download image from \(url)")
    sleep(1)

    return UIImage(url: url)
  }
  #endif

  mutating func draw() {
    // lazy var - mutating method
    print("Draw image - \(image)")
  }

  init(url: String) {
    self.url = url
  }
}

// 주의 사항
// 1) lazy var는 저장형 프로퍼티이기 때문에, 값을 변경하는 동작을 수행하기 위해서는 가변객체(struct(var) / class(var, let))에서만 사용할 수 있습니다.
// 2) struct의 경우 저장형 프로퍼티에 대해서 자동으로 초기화 메소드를 만들어 줍니다.
//    하지만 lazy var는 저장형 프로퍼티이기 때문에 외부에서 초기화될 경우 의도한 동작이 수행되지 않을 수 있습니다.
//    => 사용자 정의 초기화 메소드를 정의하는 것이 좋습니다.
// 3) 세터를 통해 image가 외부에서 변경될 경우, 초기화 블록이 제대로 수행되지 않습니다.
//    => 외부에서 수정할 수 없는 형태로 만드는 것이 좋습니다.

var image = Image(url: "https://a.com/b.png")
// image.image = UIImage(url: "https://a.com/a.png")
image.draw()
image.draw()

// var image = Image(url: "https://a.com/b.png", image: UIImage(url: "https://a.com/a.png"))
// image.draw()
// image.draw()
