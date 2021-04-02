
import RxCocoa
import RxSwift
import UIKit

class ViewController3: UIViewController {
  @IBOutlet var emailField: UITextField!
  @IBOutlet var passwordField: UITextField!

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var bottomMargin: NSLayoutConstraint!

  let disposeBag = DisposeBag()
  
  func keyboardHeight() -> Observable<CGFloat> {
    let keyboardWillShowNotification = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
      .compactMap { notificaton -> CGFloat? in
        (notificaton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
      }
    
    let keyboardWillHideNotification = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
      .map { _ -> CGFloat in
        0
      }
    
    return Observable.merge([keyboardWillShowNotification, keyboardWillHideNotification])
  }
  
  let email = BehaviorSubject<String>(value: "")
  let password = BehaviorSubject<String>(value: "")
  
  // Data Binding
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // emailField.text -> email
    emailField.rx.text
      .compactMap { $0 }
      .bind(to: email)
      .disposed(by: disposeBag)
    
    // passwordField.text -> password
    passwordField.rx.text
      .compactMap { $0 }
      .bind(to: password)
      .disposed(by: disposeBag)
    
    let emailIsValid = email
      .map { email -> Bool in
        email.count >= 5 && email.contains("@")
      }
    
    let passwordIsValid = password
      .map { password -> Bool in
        password.count >= 6
      }
    
    let isLoginButtonEnabled = Observable.combineLatest(emailIsValid, passwordIsValid)
      .map { (emailIsValid, passwordIsValid) -> Bool in
        emailIsValid && passwordIsValid
      }
    
    isLoginButtonEnabled.subscribe(onNext: { b in
      self.loginButton.isEnabled = b
    })
    .disposed(by: disposeBag)
    
    
    
    keyboardHeight()
      .map { $0 + 16 }
      .bind(to: bottomMargin.rx.constant)
      .disposed(by: disposeBag)
    
    /*
     keyboardHeight()
       .subscribe(onNext: { [weak self] height in
         self?.bottomMargin.constant = 16 + height
       })
       .disposed(by: disposeBag)
     */
      
    #if false
    // Do any additional setup after loading the view.
    NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
      .subscribe(onNext: { [weak self] notifiction in
        
        if let height = (notifiction.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
          print("keyboardWillShowNotification: \(height)")
          
          self?.bottomMargin.constant = 16 + height
        }
        
      })
      .disposed(by: disposeBag)
      
    NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
      .subscribe(onNext: { [weak self] _ in
        print("keyboardWillHideNotification")
        
        self?.bottomMargin.constant = 16
        
      })
      .disposed(by: disposeBag)
    #endif
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
