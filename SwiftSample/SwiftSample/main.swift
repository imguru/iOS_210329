import Foundation

protocol Job {
  associatedtype Input
  associatedtype Output

  func start(input: Input) -> Output
}

class UIImage {}



// Job은 PAT를 사용하고 있기 때문에,
// 아래의 코드는 제네릭 기반으로 작성되어야 합니다.
#if false
struct ImageProcessor {
  let job: Job

  func start() {
    let image = UIImage()
    let result = job.start(input: image)
    print("ImageProcessor: \(result)")
  }
}
#endif

#if false
struct ImageCropper: Job {
  let size: CGSize

  func start(input: UIImage) -> Bool {
    print("ImageCropper - \(size)")
    return true
  }
}

struct ImageProcessor<J: Job> where J.Input == UIImage, J.Output == Bool {
  let job: J

  // 아래 코드가 제대로 동작하기 위해서는
  // J.Input = UIImage
  // J.Output = Bool
  // 위의 제약이 필요합니다.
  // : where J.Input == UIImage, J.Output == Bool
  func start() {
    let image = UIImage()
    let result = job.start(input: image)
    print("ImageProcessor: \(result)")
  }
}
#endif

// struct ImageProcessor<J: Job> where J.Input == UIImage, J.Output == Bool {
// 위의 제약이 반복적으로 필요하다면, 별도의 프로토콜을 통해 모듈화할 수 있다.
protocol ImageJob: Job where Input == UIImage, Output == Bool {}

struct ImageCropper: ImageJob {
  let size: CGSize

  func start(input: UIImage) -> Bool {
    print("ImageCropper - \(size)")
    return true
  }
}

struct ImageProcessor<J: ImageJob> {
  let job: J

  // 아래 코드가 제대로 동작하기 위해서는
  // J.Input = UIImage
  // J.Output = Bool
  // 위의 제약이 필요합니다.
  // : where J.Input == UIImage, J.Output == Bool
  func start() {
    let image = UIImage()
    let result = job.start(input: image)
    print("ImageProcessor: \(result)")
  }
}

let processor = ImageProcessor(job: ImageCropper(size: CGSize(width: 100, height: 100)))
processor.start()
