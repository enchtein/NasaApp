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
  func hideKeyboardWhenTappedAround(cancellsTouchesinView: Bool = false) {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
    tap.cancelsTouchesInView = cancellsTouchesinView
    view.addGestureRecognizer(tap)
  }
  @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
  }
}
