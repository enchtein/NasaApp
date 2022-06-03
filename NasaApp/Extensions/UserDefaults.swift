//
//  UserDefaults.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-04.
//

import Foundation

extension UserDefaults {
  enum CodingKeys {
    static let shouldShowStartInfoView = "shouldShowStartInfoView"
  }
  
  //MARK: - Properties
  var showFuelPurchase: Bool {
    get { return bool(forKey: CodingKeys.shouldShowStartInfoView)}
    set { set(newValue, forKey: CodingKeys.shouldShowStartInfoView) }
  }
}
