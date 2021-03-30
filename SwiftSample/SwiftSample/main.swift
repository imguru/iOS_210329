
import Foundation

enum ApiError: Error {
  case network(String)
  case client(String)
  case server
}

struct User {
  let login: String
  let company: String
}

func getGithubUser(login: String) throws -> User {
  if login == "root" {
    throw ApiError.client("Invalid login name")
  }
  
  return User(login: login, company: "LG")
}

do {
  let user = try getGithubUser(login: "root")
  print(user)
} catch {
  print(error)
}
