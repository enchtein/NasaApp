//
//  UIApplication+Extension.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

extension UIApplication {
  
  // special extension for call from seperate class present UIController
  // you can use it : UIApplication.topViewController()?.present(..)
  class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(base: selected)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(base: presented)
    }
    return base
  }
  
  class func topModalViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let presented = base?.presentedViewController {
      return topModalViewController(base: presented)
    }
    return base
  }
}
