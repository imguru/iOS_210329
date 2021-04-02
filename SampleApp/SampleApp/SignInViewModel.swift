import Foundation
import RxSwift

// import RxCocoa
// - MVC
// Model
// View
// Controller
// => 문제점: Controller가 너무 많은 역활을 담당한다.
//          오직 UI 프레임워크에 대한 의존성이 없는 Model에 대해서만 단위 테스트 적용이 가능합니다.

//-------------
// View
// ViewModel: UI 프레임워크에 대한 의존성이 존재하면 안됩니다.
//            RxCocoa에 대한 의존성이 존재하면 안됩니다.
//            => Driver(UI 스레드)
// Model
struct SignInViewModel {
  let email = BehaviorSubject<String>(value: "")
  let password = BehaviorSubject<String>(value: "")
  
  let disposeBag = DisposeBag()
  
  lazy var emailIsValid: Observable<Bool> = {
    email
      .map { email -> Bool in
        email.count >= 5 && email.contains("@")
      }
  }()
  
  lazy var passwordIsValid: Observable<Bool> = {
    password
      .map { password -> Bool in
        password.count >= 6
      }
  }()
  
  lazy var isLoginButtonEnabled: Observable<Bool> = {
    Observable.combineLatest(emailIsValid, passwordIsValid)
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
