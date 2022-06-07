//
//  UIDevice+Extensions.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-06.
//

import UIKit

extension UIDevice {
  static var isTablet: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
}
