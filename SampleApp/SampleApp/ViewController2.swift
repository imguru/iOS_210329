import UIKit
import RxCocoa

// RxSwift
//  - RxSwift
//  - RxCocoa: UI에서 발생하는 비동기의 이벤트를 Observable을 통해 처리할 수 있습니다.

// 1. 이벤트 스트림은 onCompleted 시점에 파괴됩니다.


class ViewController2: UIViewController {
  
  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var errorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    _ = searchBar.rx.text
      .compactMap({ text -> String? in
        guard let text = text, text.count >= 3 else {
          return nil
        }
        return text.lowercased()
      })
      .subscribe(onNext: { text in
        self.errorLabel.text = text
      }, onError: { error in
        print("error - \(error)")
      }, onCompleted: {
        print("onComplete")
      })
    
  }
}
