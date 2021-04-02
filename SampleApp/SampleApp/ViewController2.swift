import RxCocoa
import RxSwift
import UIKit

// RxSwift
//  - RxSwift
//  - RxCocoa: UI에서 발생하는 비동기의 이벤트를 Observable을 통해 처리할 수 있습니다.

// 1. 이벤트 스트림은 onCompleted 시점에 파괴됩니다.
// 2. 클로저를 사용할 때, self(클래스)에 대한 참조는 순환 참조를 발생시킨다.

class ViewController2: UIViewController {
  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var errorLabel: UILabel!

  deinit {
    // 객체가 파괴되었을 때 수행되는 블록
    print("~ViewController2")
  }

  // DisposeBag 객체가 파괴되는 시점에 모든 것을 Bag안의 모든 disposable에 대해서
  // dispose를 처리한다.
  var disposeBag = DisposeBag()

  #if false
  override func viewDidLoad() {
    super.viewDidLoad()

    // * self에 대한 참조는 순환 참조에 의해 누수가 발생할 수 있습니다.
    #if false
    _ = searchBar.rx.text
      .compactMap { text -> String? in
        guard let text = text, text.count >= 3 else {
          return nil
        }
        return text.lowercased()
      }
      .subscribe(onNext: { text in
        self.errorLabel.text = text
      }, onError: { error in
        print("error - \(error)")
      }, onCompleted: {
        print("onComplete")
      })
    #endif
    // 해결 방법 1.
    //   - 약한 참조: 참조 계수를 증가시키지 않는 참조
    //     unowned / weak
    //   - unowned를 통해 참조하는 객체가 이미 파괴되었을 경우, 잘못된 참조 오류 발생의 가능성이 있습니다.
    //     : Fatal error: Attempted to read an unowned reference but the object was already deallocated
    //   - weak: autoniling - 참조하는 객체가 이미 파괴된 경우, nil로 변경해준다.

    // unowned / weak
    #if false
    _ = searchBar.rx.text
      .compactMap { text -> String? in
        guard let text = text, text.count >= 3 else {
          return nil
        }
        return text.lowercased()
      }
      .subscribe(onNext: { [weak self] text in
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
          guard let self = self else {
            print("self는 nil입니다")
            return
          }

          self.errorLabel.text = text
          // self?.errorLabel.text = text
        }
      }, onError: { error in
        print("error - \(error)")
      }, onCompleted: {
        print("onComplete")
      })
    // unowned
    // [ capture list ]
    /*
     .subscribe(onNext: { [unowned self] text in
       Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
         self.errorLabel.text = text
       }
     }, onError: { error in
       print("error - \(error)")
     }, onCompleted: {
       print("onComplete")
     })
     */
    #endif

    #if false
    let disposable = searchBar.rx.text
      .compactMap { text -> String? in
        guard let text = text, text.count >= 3 else {
          return nil
        }
        return text.lowercased()
      }
      .subscribe(onNext: { text in
        self.errorLabel.text = text
      }, onError: { error in
        print("error - \(error)")
      }, onCompleted: {
        print("onComplete")
      })

    disposeBag.insert(disposable)
    #endif

    // 해결 방법 2. self를 참조하지 말고 사용하는 view를 참조한다.
    searchBar.rx.text
      .compactMap { text -> String? in
        guard let text = text, text.count >= 3 else {
          return nil
        }
        return text.lowercased()
      }
      .subscribe(onNext: { [errorLabel] text in
        errorLabel?.text = text
      }, onError: { error in
        print("error - \(error)")
      }, onCompleted: {
        print("onComplete")
      })
      .disposed(by: disposeBag)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    // - 아래처럼 접근하는 것은 좋지 않습니다.
    // var disposeBag = Disposebag()
    // disposeBag = DisposeBag()
  }
  #endif

  // Subject
  //  => 데이터를 저장할 수도 있고, 구독을 통해 데이터의 변경도 확인할 수 있습니다.

  let errros = PublishSubject<Error>()

  override func viewDidLoad() {
    super.viewDidLoad()

    // RxSwift
    //  - 연산에서 예외가 발생할 경우 onError를 통해 알려준다.
    //  - onError가 발생하면, 이벤트스트림은 종료됩니다.
    //   => UI를 Rx를 통해 처리할 때, 오류가 발생하면, UI에 대한 이벤트 처리가 불가능합니다.
    //     : 오류가 발생하지 않도록 만들어주어야 합니다.

    //   onNext() ... -> onCompleted() -> X
    //   onNext() ....-> onError() -> X

    // errors
    // let errros = PublishSubject<Error>()
    errros
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] error in
        self?.errorLabel.text = error.localizedDescription
        print(error.localizedDescription)
      })
      .disposed(by: disposeBag)

    searchBar.rx.text
      .compactMap { text -> String? in
        guard let text = text, text.count >= 3 else {
          return nil
        }
        return text.lowercased()
      }
      .flatMap { [weak self] (login: String) -> Observable<SearchUserResponse> in
        guard let self = self else {
          return .empty()
        }

        return self.searchUser(login: login)
      }
      .subscribe(onNext: { response in
        print(response.items.count)
      }, onError: { error in
        print("onError: \(error)")
      }, onCompleted: {
        print("onCompleted")
      })
      .disposed(by: disposeBag)
  }

  func getUser(login: String) -> Observable<User> {
    let url = URL(string: "https://api.github.com/users/\(login)")!

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return getData(url: url)
      .compactMap { (data) -> User? in
        try? decoder.decode(User.self, from: data)
      }
  }

  func searchUser(login: String) -> Observable<SearchUserResponse> {
    let url = URL(string: "https://api.github.com/search/users?q=\(login)")!

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return getData(url: url)
      .compactMap { (data) -> SearchUserResponse? in
        do {
          let response = try decoder.decode(SearchUserResponse.self, from: data)
          return response
        } catch {
          self.errros.onNext(error) // !!!
          return nil
        }

        //      if let response = try? decoder.decode(SearchUserResponse.self, from: data) {
        //        return response
        //      } else {
        //        print("Error!!!!")
        //        return nil
        //      }
      }
  }
}

struct User: Decodable {
  let login: String
  let id: Int
  let avatarUrl: String
  let name: String?
  let location: String?
}

// https://api.github.com/search/users?q=\(login)
// func searchUser()
struct SearchUserResponse: Decodable {
  let totalCount: Int
  let incompleteResults: Bool
  let items: [User]
}

func getData(url: URL) -> Observable<Data> {
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

      observer.onNext(data)
      observer.onCompleted()
    }

    task.resume()
    return Disposables.create {
      task.cancel()
    }
  }
}
