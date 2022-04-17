//
//  StoryboardInitializable.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

protocol StoryboardInitializable {
  static var storyboardName: String { get }
  static var storyboardBundle: Bundle? { get }
  
  static func createFromStoryboard() -> Self
}

extension StoryboardInitializable where Self : UIViewController {
  
  static var storyboardName: String {
    return "Login"
  }
  
  static var storyboardBundle: Bundle? {
    return nil
  }
  
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
  
  static func createFromStoryboard() -> Self {
    let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
  }
  
}

//extension StoryboardInitializable where Self : SideMenuViewController {
//  static var storyboardName: String {
//    return "LeftSideMenu"
//  }
//}

extension StoryboardInitializable where Self : LoginViewController {
  static var storyboardName: String {
    return "Login"
  }
}

extension StoryboardInitializable where Self : SideMenuViewController {
  static var storyboardName: String {
    return "LeftSideMenu"
  }
}

extension StoryboardInitializable where Self : MarsRoverPhotosViewController {
  static var storyboardName: String {
    return "MarsRoverPhotos"
  }
}
