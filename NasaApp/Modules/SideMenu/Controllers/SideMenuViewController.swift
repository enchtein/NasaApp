//
//  SideMenuViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

class SideMenuViewController: BaseViewController, StoryboardInitializable {
  @IBOutlet weak var topMenuView: UIView!
  @IBOutlet weak var topMenuViewHeightContraint: NSLayoutConstraint! // default 44
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
    self.topMenuViewHeightContraint.constant = TopMenuViewHeight.zeroHeight.value
    activeController = Menu.shared.menuItems.first?.controller
    
    if !UserDefaults.standard.shouldShowStartInfoView {
      let vc = UserPromptParentViewController.createFromNib()
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self
      self.present(vc, animated: true, completion: nil)
    }
  }
//  @IBAction func changeLanguageActionTemp(_ sender: UIButton) {
//    if let targetLang = UserDefaults.standard.object(forKey: "selectedLanguage") as? String {
//      let newLang = targetLang.elementsEqual("en") ? ApplicationLanguages.russian : ApplicationLanguages.english
//      ChangeLanguageHelper.change(language: newLang)
//    } else {
//      ChangeLanguageHelper.change(language: .russian)
//    }
//  }
  override func languageDidChange() {
    super.languageDidChange()
    self.title = Menu.shared.selectedMenuItem.stringValue
  }
  
  //MARK: - Actions
  @IBAction func menuButtonPress(_ sender: UIBarButtonItem) {
    let menuVC = MenuViewController.createFromStoryboard(presentDirection: .left, topMenuViewHeight: self.topMenuView.frame.height)
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
  
  func changeTopMenuViewHeight(state: TopMenuViewHeight, completion: @escaping (() -> Void) = {}) {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
      self.topMenuViewHeightContraint.constant = state.value
      self.view.layoutIfNeeded()
    } completion: { _ in
      completion()
    }

  }
}
//MARK: - Presentation Controller processing
extension SideMenuViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    if presented is MenuViewController {
      return MenuViewPresentationController(presentedViewController: presented, presenting: presenting)
    } else if presented is UserPromptParentViewController {
      return UserPromptPresentationController(presentedViewController: presented, presenting: presenting)
    }
    return nil
  }
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if let vc = presented as? MenuViewController {
      return SlideInTransition(fromDirection: vc.presentDirection)
    } else if let vc = presented as? UserPromptParentViewController {
      return SlideInTransition(fromDirection: vc.presentDirection)
    }
    return nil
  }
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if let vc = dismissed as? MenuViewController {
      return SlideInTransition(fromDirection: vc.presentDirection, reverse: true)
    } else if let vc = dismissed as? UserPromptParentViewController {
      return SlideInTransition(fromDirection: vc.presentDirection, reverse: true)
    }
    return nil
  }
}

enum TopMenuViewHeight {
  case defaultHeight
  case zeroHeight
  
  var value: CGFloat {
    switch self {
      
    case .defaultHeight: return 44
    case .zeroHeight: return 0
    }
  }
}
