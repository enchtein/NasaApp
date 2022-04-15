//
//  TransitionProperties.swift
//  TE-DispatchSystem
//
//  Created by Track Ensure on 2022-02-03.
//

import UIKit

@objc
public protocol TransitionProperties {
  var duration: TimeInterval {get set}
  var springWithDamping: CGFloat {get set}
  var isDisabledDismissAnimation: Bool {get set}
}
