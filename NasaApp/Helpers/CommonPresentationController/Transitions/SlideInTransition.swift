//
//  SlideInTransition.swift
//  TE-DispatchSystem
//
//  Created by Track Ensure on 2022-02-03.
//

import UIKit

@objc
public enum TransitionDirection: UInt32 {
  
  case left, right, top, bottom
  
  public static func randomDirection() -> TransitionDirection {
    return TransitionDirection(rawValue: arc4random_uniform(4))!
  }
}

class SlideInTransition: NSObject, TransitionProperties {
  
  var duration: TimeInterval = 0.5
  var springWithDamping: CGFloat = 1.0
  var isDisabledDismissAnimation: Bool = false
  
  private let reverse: Bool
  private let fromDirection: TransitionDirection
  
  init(fromDirection: TransitionDirection, reverse: Bool = false) {
    self.reverse = reverse
    self.fromDirection = fromDirection
  }
}

extension SlideInTransition: UIViewControllerAnimatedTransitioning {
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    let viewControllerKey: UITransitionContextViewControllerKey = reverse ? .from : .to
    let viewControllerToAnimate = transitionContext.viewController(forKey: viewControllerKey)!
    
    let viewToAnimate = viewControllerToAnimate.view!
    viewToAnimate.frame = transitionContext.finalFrame(for: viewControllerToAnimate)
    
    let offsetFrame = fromDirection.offsetFrameForView(view: viewToAnimate, containerView: transitionContext.containerView)
    
    if !reverse {
      transitionContext.containerView.addSubview(viewToAnimate)
      viewToAnimate.frame = offsetFrame
    }
    
    let options: UIView.AnimationOptions = [.curveEaseOut]
    
    UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: springWithDamping, initialSpringVelocity: 0.0, options: options, animations: { [weak self] in
      
      guard let self = self else { return }
      
      if self.reverse && self.isDisabledDismissAnimation {
        viewToAnimate.alpha = 0
        return
      }
      
      if self.reverse == true {
        viewToAnimate.frame = offsetFrame
      } else {
        viewToAnimate.frame = transitionContext.finalFrame(for: viewControllerToAnimate)
      }
    }, completion: { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
}

private extension TransitionDirection {
  
  func offsetFrameForView(view: UIView, containerView: UIView) -> CGRect {
    
    var frame = view.frame
    
    switch self {
    case .left:
      frame.origin.x = -frame.width
    case .right:
      frame.origin.x = containerView.bounds.width
    case .top:
      frame.origin.y = -frame.height
    case .bottom:
      frame.origin.y = containerView.bounds.height
    }
    
    return frame
  }
}
