//
//  MenuViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

class MenuViewController: CommonBasedOnPresentationViewController {
  private let topMenuViewHeight: CGFloat
  private var heightForLogoView: CGFloat {
    let navBarHeight = (self.presentingViewController as? UINavigationController)?.navigationBar.frame.height ?? 0
    return topMenuViewHeight + navBarHeight
  }
  
  //MARK: - VC life cycle
  //*******************************
  private init?(coder: NSCoder, presentDirection: TransitionDirection, topMenuViewHeight: CGFloat) {
    self.topMenuViewHeight = topMenuViewHeight
    
    super.init(coder: coder, presentDirection: presentDirection)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public static func instantiate(presentDirection: TransitionDirection, topMenuViewHeight: CGFloat) -> MenuViewController {
    let storyboard = UIStoryboard(name: "LeftSideMenu", bundle: nil)
    
    let vc =  storyboard.instantiateViewController(identifier: "MenuViewController") { coder -> MenuViewController? in
      MenuViewController(coder: coder, presentDirection: presentDirection, topMenuViewHeight: topMenuViewHeight)
    }
    return vc
  }
  deinit {
    print("deinit DetailChatInfoViewController")
  }
  //*******************************
  
  @IBOutlet weak var logoView: UIView!
  @IBOutlet weak var separator: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var logoViewHeight: NSLayoutConstraint!
  weak var rootController: SideMenuViewController? = nil
  
  private let menuCellIdentifier = "menuCellIdentifier"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: self.menuCellIdentifier)
    
    let menuLogoView = MenuLogoView()
    logoView.addSubview(menuLogoView)
    menuLogoView.fillToSuperview()
    
    menuLogoView.setupMenuLogoViewConstraints()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.logoViewHeight.constant = self.heightForLogoView
  }
  
  //MARK: - Helpers
  func navigateToViewController(_ controller: UIViewController?) {
    if self.presentingViewController is UINavigationController {
      guard let parentVC = self.presentingViewController as? UINavigationController,
            let parentController = parentVC.viewControllers.last as? SideMenuViewController else { return }
      guard parentController.activeController?.classForCoder != controller?.classForCoder else {
        return
      }
      parentController.activeController = controller
    }
  }
}

//MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = Menu.shared.menuItem(with: indexPath.row)
    if Menu.shared.selectedMenuItem != item {
      self.rootController?.navigationItem.rightBarButtonItems = nil
    }
    dismiss(animated: true, completion: nil)
    Menu.shared.selectedMenuItem = item
    self.navigateToViewController(item.controller)
  }
}

//MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Menu.shared.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: self.menuCellIdentifier, for: indexPath) as? MenuTableViewCell {
      let item = Menu.shared.menuItem(with: indexPath.row)
      cell.setupCell(by: item, isSelected: item == Menu.shared.selectedMenuItem)
      
      return cell
    }
    return UITableViewCell()
  }
}
