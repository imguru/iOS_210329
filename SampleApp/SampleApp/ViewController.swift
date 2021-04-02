
import RxSwift
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
  
  /*
   // 동기
   let r1 = a()
   let r2 = b()
   c(r1, r2)
   
   // 비동기
   a { r1 in
     b { r2 in
       c(r1, r2) {
   
       }
     }
   }
   */
  
  // 3. 비동기 - URLSession - Task 기반 병렬 프로그래밍
  //   문제점: 비동기는 흐름 제어가 어렵습니다.
  //   해결방법
  //    => http://reactivex.io/
  //    => RxSwift(Reactive Extension)
  //     RxJava, RxJS ....
  #if false
  var currentTask: URLSessionTask?
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
      self.loadImageFromURL(IMAGE_URL) { image, error in
        self.loadImageFromURL(IMAGE_URL) { image, error in
          if let error = error {
            print("error - \(error)")
            return
          }
            
          self.imageView.image = image
        }
      }
    }
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
  #endif
  
  // 4. RxSwift - Reactive eXtension
  // http://reactivex.io/
  // : 비동기 기반의 이벤트 처리 코드를 작성하기 위한 라이브러리 입니다.
  //   콜백 방식과는 달리 발생하는 이벤트를 이벤트 스트림을 통해 전달하고,
  //   이벤트 스트림을 관찰하다가 원하는 이벤트를 감지하면 이에 따른 동작을 수행하는 방식을 따릅니다.
  //  => 비동기 이벤트를 컬렉션을 다루는 일반 적인 방법처럼 처리할 수 있습니다.
  
  //    Sequence     <------>    Iterator Protocol
  // -----------------------------------------------
  //    Array<int>              func next() -> Element?    => pull
  //            map/filter/flatMap
  
  //   Observable    <------>    Observer
  // -----------------------------------------------
  //                            func onNext(Element)      => push
  //                            func onError(Error)
  //                            func onComplete()
  //           map/filter/flatMap...
  
  // Rx 요소 5가지
  // 1. Observable
  //  : 이벤트를 만들어내는 주체로, 이벤트 스트림을 통해 이벤트를 내보냅니다.
  //    한개부터 여러개의 이벤트를 만들어 낼 수 있으며, 이벤트를 발생하지 않을 수도 있습니다.
  
  // 2. Observer
  //  : Observable에서 발생한 이벤트에 반응하며, 이벤트를 받았을 때 수행할 작업을 정의합니다.
  //    onNext / onError / onComplete
  //   "Observer가 Observable을 구독(subscribe)한다" 라고 합니다.
  //   => 이 순간 이벤트 스트림이 형성됩니다.
  
  // 3. Operator
  //  : 연산자는 이벤트 스트림을 통해 전달되는 이벤트를 변환하는 작업을 수행합니다.
  //    단순히 이벤트가 갖고 있는 값을 다른 형태로 넘겨주는 것 뿐 아니라, 특정 조건을 만족하는 이벤트 스트림을 생성하거나, 개수를 변경하거나
  //    다양한 작업을 수행할 수 있습니다.
  
  // 4. Scheduler
  //   : 작업을 수행할 스레드를 지정할 수 있습니다.
  //     UI 스레드 / IO 스레드 / 작업 스레드 ...
  
  // 5. Disposable
  //   : Observer가 Observable를 구독할 때 생성되는 객체 입니다.
  //     Observable에서 만드는 이벤트 스트림과 그에 필요한 리소스를 관리합니다.
  //     더 이상 이벤트를 필요로 하지 않는 경우, 해당 객체를 통해 구독을 취소할 수 있습니다.

  // UIImage
  // (completion: @escaping (UIImage?, Error?) -> Void) => Observable<UIImage>
  func loadImageFromURL(_ url: URL) -> Observable<UIImage> {
    return Observable.create { observer -> Disposable in
      
      let task = URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        guard let data = data else {
          observer.onError(NSError(domain: "Invalid data(null)", code: 100, userInfo: [:]))
          return
        }
        
        guard let image = UIImage(data: data) else {
          observer.onError(NSError(domain: "Invalid data", code: 101, userInfo: [:]))
          return
        }
        
        observer.onNext(image)
        observer.onCompleted()
      }
      
      task.resume()
      return Disposables.create()
    }
  }
  
  @IBAction func onLoad(_ sender: UIButton) {}
  
  @IBAction func onCancel(_ sender: UIButton) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
      self.timeLabel.text = "\(Date().timeIntervalSince1970)"
    }
  }
}
