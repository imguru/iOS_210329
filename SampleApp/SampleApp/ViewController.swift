
import UIKit

let IMAGE_URL = URL(string: "https://picsum.photos/1024/1024")!

class ViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var timeLabel: UILabel!
  
  // 1. 동기 버전
  @IBAction func onLoad(_ sender: UIButton) {
    guard let data = try? Data(contentsOf: IMAGE_URL) else {
      return
    }
    
    guard let image = UIImage(data: data) else {
      return
    }
    
    imageView.image = image
  }
  
  @IBAction func onCancel(_ sender: UIButton) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
}
