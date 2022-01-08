//
//  NasaTableViewCell.swift
//  NasaApp
//
//  Created by Дмитрий Хероим on 08.01.2022.
//

import UIKit

class NasaTableViewCell: UITableViewCell {
  
  //titles
  @IBOutlet weak var roverLabel: UILabel!
  @IBOutlet weak var cameraLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  //info titles
  @IBOutlet weak var roverNameLabel: UILabel!
  @IBOutlet weak var cameraNameLabel: UILabel!
  @IBOutlet weak var dateNameLabel: UILabel!
  //image
  @IBOutlet weak var roverImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
  
  func setupCell() {
    self.roverNameLabel.text = "rover test name"
    self.cameraNameLabel.text = "camera test name"
    self.dateNameLabel.text = "01.02.2021"
  }
    
}
