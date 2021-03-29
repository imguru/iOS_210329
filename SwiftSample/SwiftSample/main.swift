
import Foundation

func getAvatarImageFilename(for fileExtension: String) -> String? {
  switch fileExtension {
  case "jpg":
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

