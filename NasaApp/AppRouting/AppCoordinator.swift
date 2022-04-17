//
//  AppCoordinator.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import Foundation
import UIKit

class AppCoordinator: NSObject {
  static let shared = AppCoordinator()
  
  private var currentNavigator: UINavigationController?
  
  public private(set) var authorized: Bool = false
  
  public weak var rootSideMenuController: SideMenuViewController?
  
  func start(with window: UIWindow) {
    let loginVC = self.instantiate(.login)
    currentNavigator = BaseNavigationController(rootViewController: loginVC)
    window.rootViewController = currentNavigator
    authorized = false
    window.makeKeyAndVisible()
    
//    if let _ = UserDefaults.standard.token {
      self.activateRoot(isAppStart: true)
//    }
  }
  
  private func instantiate(_ controller: AppViewController) -> UIViewController {
    switch controller {
    case .login:
      return LoginViewController.createFromStoryboard()
    case .rootWithLeftSideMenu:
      let vc = SideMenuViewController.createFromStoryboard()
      self.rootSideMenuController = vc
      return vc
    case .selectRover:
      return MarsRoverPhotosViewController.createFromStoryboard()
    }
  }
  
  func activateRoot(isFirstLaunch: Bool = false, isAppStart: Bool = false) {
    authorized = true
    
    let rootVC = currentNavigator?.viewControllers.first
    let sideMenuVC = instantiate(.rootWithLeftSideMenu)
    currentNavigator?.setViewControllers([rootVC, sideMenuVC].compactMap { $0 }, animated: !isAppStart)
  }
  
  func present(_ controller: AppViewController, animated: Bool, completion: (() -> Void)? = nil) {
    let vc = instantiate(controller)
//    UIApplication.topModalViewController()?.presentNowOrLaterIfAnimating(vc, animated: animated, completion: completion)
    UIApplication.topModalViewController()?.present(vc, animated: animated, completion: completion)
  }
  
  func push(_ controller: AppViewController, animated: Bool = true) {
    let vc = instantiate(controller)
    if let navigation = UIApplication.topViewController()?.navigationController {
      navigation.pushViewController(vc, animated: animated)
    } else {
      currentNavigator?.pushViewController(vc, animated: animated)
    }
  }
}
