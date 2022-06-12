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
  
  private let preloader = UIActivityIndicatorView()
  
  //    override func awakeFromNib() {
  //        super.awakeFromNib()
  //        // Initialization code
  //    }
  
  //    override func setSelected(_ selected: Bool, animated: Bool) {
  //        super.setSelected(selected, animated: animated)
  //
  //        // Configure the view for the selected state
  //    }
  private var image: UIImage? {
    didSet {
      self.roverImageView.image = image
      preloader.stopAnimating()
    }
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    image = nil
    preloader.removeFromSuperview()
  }
  
  
  func setupCell(by roverInfo: RoverInfo) {
    setupLocalizeTitles(isOneActiveCamera: roverInfo.cameraNames.count == 1)
    
    self.roverNameLabel.text = roverInfo.roverName
    self.cameraNameLabel.text = adoptCamerasText(from: roverInfo.cameraNames)
    self.dateNameLabel.text = adoptDateText(from: roverInfo.dateStr)
    
    loadImage()
  }
  
  private func loadImage() {
    self.contentView.addSubview(preloader)
    preloader.translatesAutoresizingMaskIntoConstraints = false
    preloader.centerYAnchor.constraint(equalTo: roverImageView.centerYAnchor).isActive = true
    preloader.centerXAnchor.constraint(equalTo: roverImageView.centerXAnchor).isActive = true
    preloader.startAnimating()
    
    //start fetching preloader
    DispatchQueue.main.async {
      let tempIm = "https://picsum.photos/300".load() ?? UIImage(named: "ic_no_internet")!
      self.image = tempIm
    }
  }
  
  private func adoptCamerasText(from cameraNames: [String]) -> String {
    let result = "* " + cameraNames.joined(separator: "\n* ")
    
    return result
  }
  private func adoptDateText(from dateName: String) -> String {
    let result = "\(MarsRoverPhotosEnum.from.localized) " + dateName.replacingOccurrences(of: " - ", with: " \(MarsRoverPhotosEnum.to.localized) ")
    
    return result
  }
  
  private func setupLocalizeTitles(isOneActiveCamera: Bool) {
    roverLabel.text = MarsRoverPhotosEnum.name.localized
    cameraLabel.text = isOneActiveCamera ? MarsRoverPhotosEnum.camera.localized : MarsRoverPhotosEnum.cameras.localized
    dateLabel.text = MarsRoverPhotosEnum.date.localized
  }
}
