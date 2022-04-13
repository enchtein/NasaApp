//
//  LoginViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

class LoginViewController: UIViewController, StoryboardInitializable {
  
    override func viewDidLoad() {
        super.viewDidLoad()

      // filed for set api_key=DEMO_KEY (if not exist)
      // if exist - check it and ask to set if it invalid!
      // if all good - go to NasaClientViewController
//      let timer
    }
    

  @IBAction func goToRower(_ sender: UIButton) {
//    let rowerVC = NasaClientViewController.createFromStoryboard()
    AppCoordinator.shared.present(.selectRover, animated: true, completion: nil)
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
