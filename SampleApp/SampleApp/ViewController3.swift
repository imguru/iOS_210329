
import UIKit
import RxSwift
import RxCocoa

class ViewController3: UIViewController {
  @IBOutlet var emailField: UITextField!
  @IBOutlet var passwordField: UITextField!

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var bottomMargin: NSLayoutConstraint!

  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
      .subscribe(onNext: { _ in
          print("keyboardWillShowNotification")
      })
      .disposed(by: disposeBag)
      
    NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
      .subscribe(onNext: { _ in
          print("keyboardWillHideNotification")
      })
      .disposed(by: disposeBag)
    
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
}
