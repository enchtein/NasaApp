//
//  AppFont.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-16.
//

import Foundation
import UIKit

enum FontType {
  case standart
  case light
  case medium
  case bold
  
  var type: String {
    switch self {
    case .standart: return "HelveticaNeue"
    case .light: return "HelveticaNeue-Light"
    case .medium: return "HelveticaNeue-Medium"
    case .bold: return "HelveticaNeue-Bold"
    }
  }
}

struct AppFont {
  static func font(type: FontType, size: Int) -> UIFont {
    return UIFont(name: type.type, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
  }
}
