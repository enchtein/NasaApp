//
//  CommonBasedOnPresentationViewController.swift
//  TE-DispatchSystem
//
//  Created by Track Ensure on 2022-01-25.
//

import UIKit

class CommonBasedOnPresentationViewController: UIViewController {
  weak var changeState: ChangeSize?
  public var hasSetPointOrigin = false
  public var pointOrigin: CGPoint?
  
  private(set) var presentDirection: TransitionDirection = .bottom
  
  //MARK: - Need to write convinience init in inherited class for init
  //*******************************
  static func createFromNibHelper(vcType: UIViewController.Type, presentDirection: TransitionDirection = .bottom) -> Self {
    let vc = vcType.initFromNib() as! Self
    vc.presentDirection = presentDirection
    
    return vc
  }
  
  static func createFromStoryboardHelper(storyboardName: String, bundle storyboardBundle: Bundle? = nil, withIdentifier storyboardIdentifier: String, presentDirection: TransitionDirection = .bottom) -> Self {
    let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    vc.presentDirection = presentDirection
    
    return vc
  }
  //*******************************
  
  
  //MARK: - need to override for set additional settings
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if self.modalPresentationStyle == .custom {
      let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
      view.addGestureRecognizer(panGesture)
    }
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    
    self.changeState?.setBlurViewColor(blurColor: .lightGray)
  }
  
  //MARK: - need to override for set pointOrigin
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  //MARK: - override if needed
  deinit {
    print("deinit CommonBasedOnPresentationViewController")
    NotificationCenter.default.removeObserver(self)
  }
  
  //MARK: - Helpers (NOT need to override)
  @objc func appMovedToBackground() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    let dismissPanDirection: Bool
    let currentBlurAlpha: CGFloat
    let newOrigin: CGPoint
    switch self.presentDirection {
      
    case .left:
      dismissPanDirection = translation.x <= 0
      currentBlurAlpha = (self.view.frame.width + translation.x) / self.view.frame.width
      newOrigin = CGPoint(x: self.pointOrigin!.x + translation.x, y: self.view.frame.origin.y)
    case .right:
      dismissPanDirection = translation.x >= 0
      currentBlurAlpha = (self.view.frame.width - translation.x) / self.view.frame.width
      newOrigin = CGPoint(x: self.pointOrigin!.x + translation.x, y: self.view.frame.origin.y)
    case .top:
      dismissPanDirection = translation.y <= 0
      currentBlurAlpha = (self.view.frame.height + translation.y) / self.view.frame.height
      newOrigin = CGPoint(x: self.view.frame.origin.x, y: self.pointOrigin!.y + translation.y)
    case .bottom:
      dismissPanDirection = translation.y >= 0
      currentBlurAlpha = (self.view.frame.height - translation.y) / self.view.frame.height
      newOrigin = CGPoint(x: self.view.frame.origin.x, y: self.pointOrigin!.y + translation.y)
    }
    // Not allowing the user to drag the view upward
    guard dismissPanDirection else {
      if sender.state == .ended {
        self.setDefaultFrameWithAnimation()
      }
      return }
    
    //Change alpha of shadow
    if let commonPresentationController = self.presentationController as? CommonPresentationController {
      let baseValue = commonPresentationController.baseBlurViewAlpha
      let newBlurAlpha = commonPresentationController.shouldShowBlur ? baseValue - (1 - currentBlurAlpha) : baseValue
      
      commonPresentationController.blurEffectView.alpha = newBlurAlpha
    }
    
    view.frame.origin = newOrigin
    if sender.state == .ended {
      let dragVelocity = sender.velocity(in: view)
      if self.presentDirection == .left && dragVelocity.x <= -750 {
        self.dismiss(animated: true, completion: nil)
      } else if self.presentDirection == .right && dragVelocity.x >= 750 {
        self.dismiss(animated: true, completion: nil)
      } else if self.presentDirection == .top && dragVelocity.y <= -1300 {
        self.dismiss(animated: true, completion: nil)
      } else if self.presentDirection == .bottom && dragVelocity.y >= 1300 {
        self.dismiss(animated: true, completion: nil)
      } else {
        // Set back to original position of the view controller
        self.setDefaultFrameWithAnimation()
      }
    }
  }
  
  private func setDefaultFrameWithAnimation() {
    UIView.animate(withDuration: 0.3) {
      self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
      if let commonPresentationController = self.presentationController as? CommonPresentationController {
        commonPresentationController.blurEffectView.alpha =  commonPresentationController.baseBlurViewAlpha
      }
    }
  }
}
