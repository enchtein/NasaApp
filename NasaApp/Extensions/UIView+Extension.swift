//
//  UIView+Extension.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-16.
//

import UIKit

extension UIView {
  /// SwifterSwift: Anchor all sides of the view into it's superview.
  @available(iOS 9, *) public func fillToSuperview() {
    // https://videos.letsbuildthatapp.com/
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
      let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
      let top = topAnchor.constraint(equalTo: superview.topAnchor)
      let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
      NSLayoutConstraint.activate([left, right, top, bottom])
    }
  }
}
