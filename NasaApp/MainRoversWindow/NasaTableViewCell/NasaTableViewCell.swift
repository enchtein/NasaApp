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
  
  
  func setupCell(by roverInfo: RoverInfo) {
    setupLocalizeTitles(isOneActiveCamera: roverInfo.cameraNames.count == 1)
    
    self.roverNameLabel.text = roverInfo.roverName
    self.cameraNameLabel.text = adoptCamerasText(from: roverInfo.cameraNames)
    self.dateNameLabel.text = adoptDateText(from: roverInfo.dateStr)
  }
  
  private func adoptCamerasText(from cameraNames: [String]) -> String {
    let result = "* " + cameraNames.joined(separator: "\n* ")
    
    return result
  }
  private func adoptDateText(from dateName: String) -> String {
    let result = "From " + dateName.replacingOccurrences(of: " - ", with: " to ")
    
    return result
  }
  
  private func setupLocalizeTitles(isOneActiveCamera: Bool) {
    roverLabel.text = MarsRoverPhotosEnum.name.localized
    cameraLabel.text = isOneActiveCamera ? MarsRoverPhotosEnum.camera.localized : MarsRoverPhotosEnum.cameras.localized
    dateLabel.text = MarsRoverPhotosEnum.date.localized
  }
}
