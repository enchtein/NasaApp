//
//  CommonPresentationController.swift
//  TE-DispatchSystem
//
//  Created by Track Ensure on 2022-01-25.
//

import UIKit

protocol ChangeSize: AnyObject {
  func installSize(with size: CGRect)
  func setBlurViewColor(blurColor: UIColor)
}

class CommonPresentationController: UIPresentationController {
  public var baseBlurViewAlpha: CGFloat {
    return self.shouldShowBlur ? 0.7 : 1.0 // 1.0 used for UIColor.clear when shouldShowBlur == false
  }
  public let blurEffectView: UIView!
  private var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
  
  public var topBarFrame: CGRect = .zero
  private(set) var updateViewSize: CGRect?
  public var safeAreaBottomInset: CGFloat {
    return self.containerView?.safeAreaInsets.bottom ?? 0
  }
  
  //*** override this properties for set view size parameters
  open var shouldShowBlur: Bool { // if false -> baseBlurViewAlpha = 1.0 always for UIColor.clear!
    return true
  }
  open var indent: CGFloat {
    return .zero
  }
  open var height: CGFloat {
    return .zero
  }
  open var width: CGFloat {
    return .zero
  }
  let direction: TransitionDirection
  //***
  //MARK: - override init if needed
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    blurEffectView = UIView()
    blurEffectView.backgroundColor = .lightGray
    
    self.direction = (presentedViewController as? CommonBasedOnPresentationViewController)?.presentDirection ?? .bottom
    
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    if !self.shouldShowBlur {
      blurEffectView.backgroundColor = .clear
    }
    
    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
    self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.blurEffectView.isUserInteractionEnabled = true
    self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    
    if let vc = presentedViewController as? CommonBasedOnPresentationViewController {
      vc.changeState = self
    }
  }
  
  //MARK: - Dont change!
  @objc func dismissController(){
    self.presentedViewController.dismiss(animated: true, completion: nil)
  }
  
  override var frameOfPresentedViewInContainerView: CGRect {
    let viewSettings: CGRect = CGRect(x: self.containerView!.frame.width / 2, y: self.indent, width: self.width, height: self.height)
    switch self.direction {
      
    case .left, .right:
      return CGRect(origin: CGPoint(x: (self.containerView!.frame.height / 2) - (viewSettings.size.height / 2), y: indent), size: viewSettings.size)
    case .top, .bottom:
      return CGRect(origin: CGPoint(x: (self.containerView!.frame.width / 2) - (viewSettings.size.width / 2), y: indent), size: viewSettings.size)
    }
//    let viewSettings: CGRect = CGRect(x: self.containerView!.frame.width / 2, y: self.indent, width: self.width, height: self.height)
    
//    return CGRect(origin: CGPoint(x: (self.containerView!.frame.width / 2) - (viewSettings.size.width / 2), y: indent), size: viewSettings.size)
  }
  
  override func presentationTransitionWillBegin() {
    self.blurEffectView.alpha = 0
    self.containerView?.addSubview(blurEffectView)
    self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
      self.blurEffectView.alpha = self.baseBlurViewAlpha
    }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
  }
  
  override func dismissalTransitionWillBegin() {
    self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
      self.blurEffectView.alpha = 0
    }, completion: { (UIViewControllerTransitionCoordinatorContext) in
      self.blurEffectView.removeFromSuperview()
    })
  }
  
  //MARK: - Override to set cornerRadius (only if needed)
  override func containerViewWillLayoutSubviews() {
    super.containerViewWillLayoutSubviews()
    presentedView!.roundCorners(.allCorners, radius: 13)
    presentedView!.clipsToBounds = true
  }
  
  //MARK: - Override to set vc.pointOrigin on rotate (only if needed)
  override func containerViewDidLayoutSubviews() {
    super.containerViewDidLayoutSubviews()
    blurEffectView.frame = containerView!.bounds
    UIView.animate(withDuration: 0.5) { // was 1
      self.presentedView?.frame = self.frameOfPresentedViewInContainerView
      if let commonBasedOnPresentationViewController = self.presentedViewController as? CommonBasedOnPresentationViewController {
        commonBasedOnPresentationViewController.pointOrigin = self.presentedView?.frame.origin // update origin for correct work panGesture
      }
    }
  }
}

extension CommonPresentationController: ChangeSize {
  func setBlurViewColor(blurColor: UIColor) {
    if self.shouldShowBlur {
      self.blurEffectView.backgroundColor = blurColor
    }
  }
  
  func installSize(with size: CGRect) {
    self.updateViewSize = size
    self.containerViewDidLayoutSubviews()
  }
}
