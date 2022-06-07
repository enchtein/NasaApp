//
//  UserPromptPresentationController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-04.
//

import UIKit

class UserPromptPresentationController: CommonPresentationController {
  override var height: CGFloat {
    return self.containerView!.frame.height * 0.8
  }
  override var width: CGFloat {
    return self.containerView!.frame.width * 0.8
  }
  
  override var indent: CGFloat {
//    return .zero
    return (self.containerView!.frame.height - height) / 2
  }
}
