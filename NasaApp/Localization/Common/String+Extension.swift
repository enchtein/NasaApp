//
//  String+Extension.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-24.
//

import UIKit

extension String {
  
  func localized(bundle: Bundle = .main, tableName: String = "Localization") -> String {
    return bundle.localizedString(forKey: self, value: "*\(self)*", table: tableName)
  }
}
