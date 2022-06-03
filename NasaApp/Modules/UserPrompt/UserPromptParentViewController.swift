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
    print("deinit ChatNameViewController")
  }
  //*******************************
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
