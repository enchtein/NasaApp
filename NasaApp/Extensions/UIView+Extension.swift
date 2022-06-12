//
//  UIView+Extension.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-16.
//

import UIKit

extension UIView {
  /// SwifterSwift: Anchor all sides of the view into it's superview.
  @available(iOS 9, *) public func fillToSuperview(sideIndent: CGFloat = .zero) {
    // https://videos.letsbuildthatapp.com/
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: sideIndent)
      let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -sideIndent)
      let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: sideIndent)
      let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -sideIndent)
      NSLayoutConstraint.activate([left, right, top, bottom])
    }
  }
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      if #available(iOS 11, *) {
          var cornerMask = CACornerMask()
          if(corners.contains(.topLeft)){
              cornerMask.insert(.layerMinXMinYCorner)
          }
          if(corners.contains(.topRight)){
              cornerMask.insert(.layerMaxXMinYCorner)
          }
          if(corners.contains(.bottomLeft)){
              cornerMask.insert(.layerMinXMaxYCorner)
          }
          if(corners.contains(.bottomRight)){
              cornerMask.insert(.layerMaxXMaxYCorner)
          }
          self.layer.cornerRadius = radius
          self.layer.maskedCorners = cornerMask

      } else {
          let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
          let mask = CAShapeLayer()
          mask.path = path.cgPath
          self.layer.mask = mask
      }
  }
}
