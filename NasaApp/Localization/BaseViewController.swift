//
//  BaseViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

class BaseViewController: UIViewController {
  
  public private(set) var isAppeared = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      NotificationCenter.default.addObserver(self, selector: #selector(self.languageDidChangeNotification(notification:)), name: NSNotification.Name.languageDidCnahge, object: nil)
      languageDidChange()
      setupFont()
      
      modalPresentationCapturesStatusBarAppearance = true
      setNeedsStatusBarAppearanceUpdate()
      
      self.navigationItem.backButtonTitle = ""
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    isAppeared = true
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    isAppeared = false
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  //MARK: - Public API
  @objc func languageDidChange() {}
  //MARK: - Private methods

  @objc private func languageDidChangeNotification(notification: NSNotification) {
    languageDidChange()
  }

  // MARK: - AppFont
  public func setupFont() {}
}

//MARK: - BaseNavigationController
class BaseNavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    modalPresentationCapturesStatusBarAppearance = true
    setNeedsStatusBarAppearanceUpdate()
  }
}
