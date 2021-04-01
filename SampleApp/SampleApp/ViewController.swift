
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
  //  문제점: '취소'가 가능해야 한다.
  //  해결방법
  //  - Data를 통해 요청하는 것이 아니라, URLSessionDataTask를 통해 해당 기능을 제공할 수 있습니다.
  #if false
  func loadImageFromURL(_ url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
    DispatchQueue.global().async {
      guard let data = try? Data(contentsOf: IMAGE_URL) else {
        DispatchQueue.main.async {
          completion(nil, NSError(domain: "Invalid URL", code: 100, userInfo: [:]))
        }
        return
      }
      
      guard let image = UIImage(data: data) else {
        DispatchQueue.main.async {
          completion(nil, NSError(domain: "Invalid Image Data", code: 101, userInfo: [:]))
        }
        return
      }
      
      DispatchQueue.main.async {
        completion(image, nil)
      }
    }
  }
  
  @IBAction func onLoad(_ sender: UIButton) {
    loadImageFromURL(IMAGE_URL) { image, error in
      if let error = error {
        print("error - \(error)")
        return
      }
            
      // DispatchQueue.main.async {
      self.imageView.image = image
      // }
    }
  }
  #endif
  
  #if false
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
  #endif
  
  // 3. 비동기 - URLSession
  var currentTask: URLSessionTask? = nil
  
  func loadImageFromURL(_ url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
    currentTask?.cancel()
    currentTask = nil
    
    let task = URLSession.shared.dataTask(with: url) { (data, response: URLResponse?, error) in
      if let error = error {
        DispatchQueue.main.async { completion(nil, error) }
        return
      }
      
      // HTTP protocol
      //  statusCode: 200..<300 - OK
      guard let response = response as? HTTPURLResponse else {
        DispatchQueue.main.async { completion(nil, NSError(domain: "Invalid response", code: 100, userInfo: [:])) }
        return
      }
      
      guard 200 ..< 300 ~= response.statusCode else {
        DispatchQueue.main.async { completion(nil, NSError(domain: "Failed - statusCode: \(response.statusCode)", code: 101, userInfo: [:])) }
        return
      }
      
      guard let data = data else {
        DispatchQueue.main.async { completion(nil, NSError(domain: "Empty data", code: 101, userInfo: [:])) }
        return
      }
      
      guard let image = UIImage(data: data) else {
        DispatchQueue.main.async { completion(nil, NSError(domain: "Invalid data", code: 101, userInfo: [:])) }
        return
      }
      
      DispatchQueue.main.async { completion(image, nil) }
    }
    
    currentTask = task
    task.resume()
  }
  
  @IBAction func onLoad(_ sender: UIButton) {
    loadImageFromURL(IMAGE_URL) { image, error in
      if let error = error {
        print("error - \(error)")
        return
      }
            
      self.imageView.image = image
    }
  }
  
  @IBAction func onCancel(_ sender: UIButton) {
    currentTask?.cancel()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
      self.timeLabel.text = "\(Date().timeIntervalSince1970)"
    }
  }
}
