//
//  SideMenuViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

class SideMenuViewController: BaseViewController, StoryboardInitializable {
  @IBOutlet weak var topMenuView: UIView!
  @IBOutlet weak var containerView: UIView!
  
  var activeController: UIViewController? {
    didSet {
      remove(asChildViewController: oldValue)
      updateActiveViewController()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    Menu.shared.reloadMenuItems()
    activeController = Menu.shared.menuItems.first?.controller
  }
  
  //MARK: - Actions
  @IBAction func menuButtonPress(_ sender: UIBarButtonItem) {
    let menuVC = MenuViewController.instantiate(presentDirection: .left, topMenuViewHeight: self.topMenuView.frame.height)
    menuVC.modalPresentationStyle = .custom
    menuVC.transitioningDelegate = self
    menuVC.rootController = self
    
    self.present(menuVC, animated: true, completion: nil)
  }
  //MARK: - Change child VC
  public func remove(asChildViewController viewController: UIViewController?) {
    viewController?.willMove(toParent: nil)
    viewController?.view.removeFromSuperview()
    viewController?.removeFromParent()
  }
  public func updateActiveViewController() {
    guard let _ = self.containerView else { return }
    guard let activeVC = self.activeController else { return }
    
    self.addChild(activeVC)
    activeVC.view.frame = self.containerView.bounds
    self.containerView.addSubview(activeVC.view)
    activeVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    activeVC.didMove(toParent: self)
    self.view.layoutSubviews()
    self.title = Menu.shared.selectedMenuItem.stringValue
  }
}
//MARK: - Presentation Controller processing
extension SideMenuViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    if presented is MenuViewController {
      return MenuViewPresentationController(presentedViewController: presented, presenting: presenting)
    }
    return nil
  }
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if let vc = presented as? MenuViewController {
      return SlideInTransition(fromDirection: vc.presentDirection)
    }
    return nil
  }
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if let vc = dismissed as? MenuViewController {
      return SlideInTransition(fromDirection: vc.presentDirection, reverse: true)
    }
    return nil
  }
}
