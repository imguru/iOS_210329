
import Foundation

#if false
func getAvatarImageFilename(for fileExtension: String) -> String? {
  switch fileExtension.lowercased() {
  case "jpg", "jpeg":
    return "avatar.jpg"
  case "bmp":
    return "avatar.bmp"
  case "gif":
    return "avatar.gif"

  // 단일 실패의 처리는 Optional이 유용합니다.
  default:
    return nil
  }
}

if let result = getAvatarImageFilename(for: "jpg") {
  print(result)
}

if let result = getAvatarImageFilename(for: "jpeg") {
  print(result)
}

if let result = getAvatarImageFilename(for: "JPG") {
  print(result)
}
#endif

// enum - rawValue
//   - Int, Double, Float, String

enum ImageType: String {
  case jpg
  case bmp
  case gif

  // 실패할 경우, nil을 반환하는 초기화 메소드 입니다.
  init?(rawValue: String) {
    switch rawValue.lowercased() {
    case "jpg", "jpeg":
      self = .jpg
    case "bmp":
      self = .bmp
    case "gif":
      self = .gif
    default:
      return nil
    }
  }
}

func getAvatarImageFilename(for fileExtension: String) -> String? {
  if let imageType = ImageType(rawValue: fileExtension) {
    return "avatar.\(imageType.rawValue)"
  } else {
    return nil
  }
}
