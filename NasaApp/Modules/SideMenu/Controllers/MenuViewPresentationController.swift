//
//  MenuViewPresentationController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-15.
//

import UIKit

class MenuViewPresentationController: CommonPresentationController {
  override var height: CGFloat {
    return self.containerView!.frame.height
  }
  override var width: CGFloat {
//    return self.containerView!.frame.width * 0.5
//    let multiplier = UIDevice.current.userInterfaceIdiom == .phone ? 0.8 : 0.4
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    let isPortrait = UIDevice.current.orientation == .portrait
    
    let multiplier: Double
    switch (isPhone, isPortrait) {
    case (true, true): multiplier = 0.8
    case (true, false): multiplier = 0.5
    case (false, true): multiplier = 0.5
    case (false, false): multiplier = 0.4
    }
    return self.containerView!.frame.width * multiplier
  }
}
