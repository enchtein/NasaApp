//
//  RoverWindowViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-17.
//

import UIKit
import PromiseKit

class RoverWindowViewController: BaseViewController, StoryboardInitializable {
  
  private let cellIdentifier = "NasaTableViewCell"

  @IBOutlet weak var rover: UIView!
  @IBOutlet weak var roverControl: UIControl!
  @IBOutlet weak var roverName: UILabel!
  @IBOutlet weak var roverImage: UIImageView!
  @IBOutlet weak var camera: UIView!
  @IBOutlet weak var cameraControl: UIControl!
  @IBOutlet weak var cameraName: UILabel!
  @IBOutlet weak var cameraImage: UIImageView!
  @IBOutlet weak var date: UIView!
  @IBOutlet weak var dateControl: UIControl!
  @IBOutlet weak var dateName: UILabel!
  @IBOutlet weak var dateImage: UIImageView!
  
  @IBOutlet weak var roverTable: UITableView!
  
  
  private var tempDataSource = [Rovers]()
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.fetchRequestAll()
    
    //set images
    roverImage.image = UIImage(named: "icon_rover")
    cameraImage.image = UIImage(named: "icon_camera")
    dateImage.image = UIImage(named: "icon_date")
    
    self.additionalSettings()
    
    
    }
  
  override func setupFont() {
    [roverName, cameraName, dateName].forEach({$0?.font = AppFont.font(type: .standart, size: 15)})
  }
  override func setupColorTheme() {
    let theme = EventForControl.touchEnd // as default
    [roverName, cameraName, dateName].forEach({$0?.textColor = theme.colorThemeText})
    [roverImage, cameraImage, dateImage].forEach({$0?.tintColor = theme.colorThemeImage})
  }
    
  private func additionalSettings() {
    [rover, camera, date].forEach {
      $0?.clipsToBounds = true
      $0?.layer.cornerRadius = 8
    }
    
    self.roverTable.delegate = self
    self.roverTable.dataSource = self
    self.roverTable.register(UINib(nibName: "NasaTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
  }
  
  //MARK: - Network Task's
  func fetchRequestAll() {
      firstly { Provider.performRequestAll() }.done { [weak self] (response) in
        if let rovers = response.rovers {
          self?.tempDataSource = rovers
        }
        
        self?.roverTable.reloadData()
      } .catch { (error) in
          debugPrint(error.localizedDescription)
      }
  }
  
  //MARK: - UIControl Actions
  @IBAction func touchDownAction(_ sender: UIControl) {
    print("touchDownAction")
    self.eventReact(for: sender, with: .touchBegin)
  }
  @IBAction func touchUpInsideAction(_ sender: UIControl) {
    print("touchUpInsideAction")
    self.eventReact(for: sender, with: .touchEnd)
  }
  @IBAction func touchDragExitAction(_ sender: UIControl) {
    print("touchDragExit")
    self.eventReact(for: sender, with: .touchEnd)
  }
}

//MARK: - Rover UITableViewDelegate
extension RoverWindowViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = roverTable.cellForRow(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
//MARK: - Rover UITableViewDataSource
extension RoverWindowViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.tempDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = roverTable.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? NasaTableViewCell {
      cell.roverNameLabel.text = self.tempDataSource[indexPath.row].name
      
      return cell
    }
    return UITableViewCell()
  }
  
  
}

//MARK: - Heplers
extension RoverWindowViewController {
  private func eventReact(for sender: UIControl, with event: EventForControl) {
    if sender === roverControl {
      roverName.textColor = event.colorThemeText
      roverImage.tintColor = event.colorThemeImage
    } else if sender === cameraControl {
      cameraName.textColor = event.colorThemeText
      cameraImage.tintColor = event.colorThemeImage
      
    } else if sender === dateControl {
      dateName.textColor = event.colorThemeText
      dateImage.tintColor = event.colorThemeImage
    } else {
      fatalError("unknown sender!")
    }
  }
  
  fileprivate enum EventForControl {
    case touchBegin
    case touchEnd
    
    var colorThemeText: UIColor? {
      switch self {
      case .touchBegin: return .red
      case .touchEnd: return .label
      }
    }
    var colorThemeImage: UIColor? {
      switch self {
      case .touchBegin: return .red
      case .touchEnd: return .lightGray
      }
    }
  }
}
