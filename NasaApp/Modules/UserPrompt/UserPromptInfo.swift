//
//  UserPromptInfo.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-08.
//

import Foundation

class UserPromptInfo {
  let imageNames: [String]
  let text: String
  
  init(imageNames: [String], text: String) {
    self.imageNames = imageNames
    self.text = text
  }
}

//MARK: - UserDefaults.standard.isShownStartInfoView
extension UserPromptInfo {
  static func getStartInfoView() -> [UserPromptInfo] {
    let info: [UserPromptInfo] = [
      UserPromptInfo(imageNames: ["first_one", "first_two", "first_three"], text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      UserPromptInfo(imageNames: ["second_one", "second_two", "second_three"], text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      UserPromptInfo(imageNames: ["third_one", "third_two", "third_three"], text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    ]
    
    return info
  }
}
