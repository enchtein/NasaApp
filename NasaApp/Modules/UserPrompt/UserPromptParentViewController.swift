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
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
