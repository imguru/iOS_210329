
import UIKit

let IMAGE_URL = URL(string: "https://picsum.photos/2048/2048")!

class ViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var timeLabel: UILabel!
  

  // 1. 동기 버전
  //   문제점: UI 스레드에서 오래 걸리는 작업을 수행하면 UI의 업데이트가 멈추는 문제가 발생합니다.
  //   해결방법
  //    => 비동기로 처리해야 합니다.
  #if false
  @IBAction func onLoad(_ sender: UIButton) {
    guard let data = try? Data(contentsOf: IMAGE_URL) else {
      return
    }
    
    guard let image = UIImage(data: data) else {
      return
    }
    
    imageView.image = image
  }
  #endif
  
  // 2. 비동기 버전 - GCD(Grand Central Dispatch)
  @IBAction func onLoad(_ sender: UIButton) {
    DispatchQueue.global().async {
      guard let data = try? Data(contentsOf: IMAGE_URL) else {
        return
      }
      
      guard let image = UIImage(data: data) else {
        return
      }
      
      // 화면에 업데이트는 반드시 UI 스레드에서 수행되어야 한다.
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    }
  }
  
  
  
  @IBAction func onCancel(_ sender: UIButton) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
      self.timeLabel.text = "\(Date().timeIntervalSince1970)"
    }
  }
}
