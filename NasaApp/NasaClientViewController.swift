//
//  ViewController.swift
//  NasaApp
//
//  Created by Дмитрий Хероим on 08.01.2022.
//

import UIKit

class NasaClientViewController: UIViewController {

  @IBOutlet weak var nasaClientTable: UITableView!
  
  let cellIdentifier = "NasaTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.nasaClientTable.register(UINib(nibName: "NasaTableViewCell", bundle: .main), forCellReuseIdentifier: self.cellIdentifier)
  }


}

