
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


