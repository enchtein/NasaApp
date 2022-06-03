//
//  UIViewController+Extensions.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-04.
//

import Foundation
import UIKit

extension UIViewController {
  static func initFromNib() -> Self {
      func instanceFromNib<T: UIViewController>() -> T {
          return T(nibName: String(describing: self), bundle: nil)
      }
      return instanceFromNib()
  }
}
