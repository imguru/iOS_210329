
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
  lazy var image: UIImage = {
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
}

// 주의 사항
// 1) 저장형 프로퍼티이기 때문에, 값을 변경하는 동작을 수행하기 위해서는 가변객체(struct(var) / class(var, let))에서만 사용할 수 있습니다.

var image = Image(url: "https://a.com/b.png")
image.draw()
image.draw()
