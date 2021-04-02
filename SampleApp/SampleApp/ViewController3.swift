
import RxCocoa
import RxSwift
import UIKit

#if false
struct SignInViewModel {
  let email = BehaviorSubject<String>(value: "")
  let password = BehaviorSubject<String>(value: "")
  
  let disposeBag = DisposeBag()
  
  lazy var emailIsValid: Driver<Bool> = {
    email
      .asDriver(onErrorJustReturn: "")
      .map { email -> Bool in
        email.count >= 5 && email.contains("@")
      }
  }()
  
  lazy var passwordIsValid: Driver<Bool> = {
    password
      .asDriver(onErrorJustReturn: "")
      .map { password -> Bool in
        password.count >= 6
      }
  }()
  
  lazy var isLoginButtonEnabled: Driver<Bool> = {
    Driver.combineLatest(emailIsValid, passwordIsValid)
      .map { (emailIsValid, passwordIsValid) -> Bool in
        emailIsValid && passwordIsValid
      }
  }()
  
  lazy var keyboardHeight: Observable<CGFloat> = {
    let keyboardWillShowNotification = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
      .compactMap { notificaton -> CGFloat? in
        (notificaton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
      }
    
    let keyboardWillHideNotification = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
      .map { _ -> CGFloat in
        0
      }
    
    return Observable.merge([keyboardWillShowNotification, keyboardWillHideNotification])
  }()
}
#endif

// MVVM(Model - View - ViewModel)
class ViewController3: UIViewController {
  @IBOutlet var emailField: UITextField!
  @IBOutlet var passwordField: UITextField!

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var bottomMargin: NSLayoutConstraint!
  
  var viewModel = SignInViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // emailField.text -> viewModel.email
    emailField.rx.text
      .asDriver()
      .compactMap { $0 }
      .drive(viewModel.email)
      .disposed(by: viewModel.disposeBag)
    
    // passwordField.text -> viewModel.password
    passwordField.rx.text
      .asDriver()
      .compactMap { $0 }
      .drive(viewModel.password)
      .disposed(by: viewModel.disposeBag)
    
    // viewModel.isLoginButtonEnabled -> loginButton.isEnabled
    viewModel.isLoginButtonEnabled
      .asDriver(onErrorJustReturn: false)
      .drive(loginButton.rx.isEnabled)
      .disposed(by: viewModel.disposeBag)
    
    // viewModel.keyboardHeight -> bottomMargin.constant
    viewModel.keyboardHeight
      .map { $0 + 16 }
      .bind(to: bottomMargin.rx.constant)
      .disposed(by: viewModel.disposeBag)
    
    loginButton.rx.tap
      .flatMapLatest { [weak self] _ -> Observable<User> in
        guard let self = self else {
          return Observable.empty()
        }
        return self.viewModel.login()
      }
      .subscribe(onNext: { user in
        print("Login 성공: \(user)")
      }, onError: { error in
        print("Login 실패: \(error)")
      })
      .disposed(by: viewModel.disposeBag)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}

// -----------

#if false
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
  
  // Observable 기반 입니다.
  let email = BehaviorSubject<String>(value: "")
  let password = BehaviorSubject<String>(value: "")
  
  // let email = BehaviorRelay<String>(value: "")
  // let password = BehaviorRelay<String>(value: "")
  
  // Data Binding
  // 1. Observable
  #if false
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
  #endif

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // emailField.text -> email
    emailField.rx.text
      .asDriver()
      .compactMap { $0 }
      .drive(email)
      .disposed(by: disposeBag)
    
    // passwordField.text -> password
    passwordField.rx.text
      .asDriver()
      .compactMap { $0 }
      .drive(password)
      .disposed(by: disposeBag)
    
    let emailIsValid = email
      .asDriver(onErrorJustReturn: "")
      .map { email -> Bool in
        email.count >= 5 && email.contains("@")
      }
    
    let passwordIsValid = password
      .asDriver(onErrorJustReturn: "")
      .map { password -> Bool in
        password.count >= 6
      }
    
    let isLoginButtonEnabled = Driver.combineLatest(emailIsValid, passwordIsValid)
      .map { (emailIsValid, passwordIsValid) -> Bool in
        emailIsValid && passwordIsValid
      }

    isLoginButtonEnabled.drive(loginButton.rx.isEnabled)
      .disposed(by: disposeBag)

//    isLoginButtonEnabled.drive(onNext: { b in
//      self.loginButton.isEnabled = b
//    })
//    .disposed(by: disposeBag)
    
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
#endif
