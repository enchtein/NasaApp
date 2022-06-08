//
//  UserPromptPageViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-08.
//

import UIKit

class UserPromptPageViewController: UIPageViewController {
  //*******************************
  let promptsInfo: [UserPromptInfo]
  init(promptsInfo: [UserPromptInfo]) {
    self.promptsInfo = promptsInfo
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 10])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //*******************************
  
  var currentIndex: Int!
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      let viewController = viewPhotoCommentController(currentIndex ?? 0)
      let viewControllers = [viewController]

      setViewControllers(viewControllers,
                         direction: .forward,
                         animated: false,
                         completion: nil)

      self.view.backgroundColor = .yellow//self.colorTheme.chat_background
      dataSource = self
      delegate = self
    }
    
  func viewPhotoCommentController(_ index: Int) -> UserPromptViewController {
    let promptInfo = self.promptsInfo[index]
    
    let page = UserPromptViewController(promptInfo: promptInfo)
    page.photoIndex = index

    return page
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UIPageViewControllerDataSource
extension UserPromptPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? UserPromptViewController,
       let index = viewController.photoIndex,
       index > 0 {
      return viewPhotoCommentController(index - 1)
    }
    
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let childVC = viewController as? UserPromptViewController,
       let index = childVC.photoIndex,
       (index + 1) < promptsInfo.count {
      return viewPhotoCommentController(index + 1)
    }
    
    return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return promptsInfo.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}
//MARK: - UIPageViewControllerDelegate
extension UserPromptPageViewController: UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let currentVC = pageViewController.viewControllers?.first as? UserPromptViewController
    self.currentIndex = currentVC?.photoIndex ?? 0
    
//    let imageViewingVC = self.parent as? ImageViewingViewController
//    imageViewingVC?.updateTopBarLabel()
  }
}
