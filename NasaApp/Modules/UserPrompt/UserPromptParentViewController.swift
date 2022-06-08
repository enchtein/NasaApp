//
//  UserPromptParentViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-04.
//

import UIKit

class UserPromptParentViewController: CommonBasedOnPresentationViewController {
  //*******************************
  static func createFromNib() -> Self {
    let vc = super.createFromNibHelper(vcType: Self.self)
    
    return vc
  }
  
  deinit {
    print("deinit UserPromptParentViewController")
  }
  //*******************************
  
  @IBOutlet weak var containerView: UIView!
  private var pageControllVC: UserPromptPageViewController!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      pageControllVC = UserPromptPageViewController(promptsInfo: UserPromptInfo.getStartInfoView())
      pageControllVC.currentIndex = 0 // from start index
      
      addChild(pageControllVC)
      containerView.addSubview(pageControllVC.view)
      
      pageControllVC.view.translatesAutoresizingMaskIntoConstraints = false
      pageControllVC.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
      pageControllVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
      pageControllVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
      pageControllVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
      
      pageControllVC.didMove(toParent: self)
      
      setupUI()
    }

  private func setupUI() {
    let pageControl = UIPageControl.appearance()
    pageControl.pageIndicatorTintColor = UIColor.lightGray
    pageControl.currentPageIndicatorTintColor = UIColor.darkGray
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func closeButtonAction(_ sender: UIButton) {
    self.dismiss(animated: true)
  }
}
