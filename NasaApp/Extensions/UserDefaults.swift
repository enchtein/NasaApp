//
//  UserDefaults.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-04.
//

import Foundation

extension UserDefaults {
  enum CodingKeys {
    static let isShownStartInfoView = "isShownStartInfoView"
  }
  
  //MARK: - Properties
  var isShownStartInfoView: Bool {
    get { return bool(forKey: CodingKeys.isShownStartInfoView)}
    set { set(newValue, forKey: CodingKeys.isShownStartInfoView) }
  }
}
