//
//  MarsRoverPhotosViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-17.
//

import UIKit
import PromiseKit

class MarsRoverPhotosViewController: BaseViewController, StoryboardInitializable {
  
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
  
  @IBOutlet weak var editingTextField: UITextField!
  @IBOutlet weak var roverTable: UITableView!
  
  
  private var tempDataSource = [Rovers]()
  private var correctDataSource = [RoverInfo]()
  
  private lazy var roverDataPicker: UIPickerView = {
    let roverDataPicker = UIPickerView()
    //    let roverDataPicker = UIPickerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 300, width: self.view.frame.size.width, height: 300))
    roverDataPicker.dataSource = self
    roverDataPicker.delegate = self
    roverDataPicker.autoresizingMask = .flexibleWidth
    
    return roverDataPicker
  }()
  private lazy var roverDataSource = [String]()
  private lazy var roverDatePicker: UIDatePicker = {
    let roverDatePicker = UIDatePicker()
    roverDatePicker.datePickerMode = .date
    roverDatePicker.preferredDatePickerStyle = .wheels
    roverDatePicker.autoresizingMask = .flexibleWidth
    
    return roverDatePicker
  }()
  private lazy var pickerToolbar: UIToolbar = {
    let pickerToolbar = UIToolbar()
    
    pickerToolbar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
    pickerToolbar.sizeToFit()
    
    return pickerToolbar
  }()
  @objc private func onDoneButtonTapped(_ sender: UIBarButtonItem) {
    print("onDoneButtonTapped")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    roverTable.rowHeight = UITableView.automaticDimension
    roverTable.estimatedRowHeight = 600
    self.fetchRequestAll()
    
    //set images
    roverImage.image = UIImage(named: "icon_rover")
    cameraImage.image = UIImage(named: "icon_camera")
    dateImage.image = UIImage(named: "icon_date")
    
    self.additionalSettings()
    
    //    self.hideKeyboardWhenTappedAround()
  }
  
  override func setupFont() {
    [roverName, cameraName, dateName].forEach({$0?.font = AppFont.font(type: .standart, size: 15)})
  }
  override func setupColorTheme() {
    let theme = EventForControl.touchEnd // as default
    [roverName, cameraName, dateName].forEach({$0?.textColor = theme.colorThemeText})
    [roverImage, cameraImage, dateImage].forEach({$0?.tintColor = theme.colorThemeImage})
  }
  override func languageDidChange() {
    super.languageDidChange()
    self.roverTable.reloadData()
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
  private func setPicker(for sender: UIControl) {
    if sender === roverControl || sender === cameraControl {
      // show data picker
      editingTextField.inputView = self.roverDataPicker
      editingTextField.inputAccessoryView = self.pickerToolbar
      editingTextField.becomeFirstResponder()
    } else if sender === dateControl {
      // show date picker
    } else {
      fatalError("unknown sender!")
    }
  }
  
  //MARK: - Network Task's
  func fetchRequestAll() {
    firstly { Provider.performRequestAll() }.done { [weak self] (response) in
      if let rovers = response.rovers {
        self?.tempDataSource = rovers
        self?.setDataSource()
      }
      
      self?.roverTable.reloadData()
      if let sideMenuVC = self?.parent as? SideMenuViewController {
        sideMenuVC.changeTopMenuViewHeight(state: .defaultHeight)
      }
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
    
    if sender === roverControl {
      //set dataSource or date range
      self.roverDataSource = self.correctDataSource.map {$0.roverName}
    } else if sender === cameraControl {
      //set dataSource or date range
      self.roverDataSource = Array(Set(self.correctDataSource.map {$0.cameraNames}.flatMap {$0})).sorted(by: {$0 < $1})
    } else if sender === dateControl {
      //show date picker
    } else {
      fatalError("unknown sender!")
    }
    
    self.setPicker(for: sender)
  }
  @IBAction func touchDragExitAction(_ sender: UIControl) {
    print("touchDragExit")
    self.eventReact(for: sender, with: .touchEnd)
  }
}

//MARK: - Rover UITableViewDelegate
extension MarsRoverPhotosViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = roverTable.cellForRow(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
//MARK: - Rover UITableViewDataSource
extension MarsRoverPhotosViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    self.tempDataSource.count
    self.correctDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = roverTable.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? NasaTableViewCell {
      cell.setupCell(by: self.correctDataSource[indexPath.row])
      
      return cell
    }
    return UITableViewCell()
  }
}
//MARK: - UIPickerViewDataSource
extension MarsRoverPhotosViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    self.roverDataSource.count
  }
}
//MARK: - UIPickerViewDelegate
extension MarsRoverPhotosViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    self.roverDataSource[row]
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.roverName.text = self.roverDataSource[row]
  }
}
// MARK: - UIContextMenu
extension MarsRoverPhotosViewController {
  func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let index = indexPath.row
    
    return self.configureContextMenu(index: index)
  }
  
  private func configureContextMenu(index: Int) -> UIContextMenuConfiguration? {
    guard let cell = self.roverTable.cellForRow(at: IndexPath(row: index, section: 0)) as? NasaTableViewCell else {return nil}
    
    let im = UIImage(named: "ic_favourites_add")?.withTintColor(.label, renderingMode: .alwaysTemplate) //ic_favourites_remove
    let favorite = UIAction(title: "Add to favourites", image: im) { _ in
      print("test *Should add to UserDefaults*")
    }
    
    let identifier = "\(index)" as NSString
    let configuration = UIContextMenuConfiguration(identifier: identifier) { () -> UIViewController? in
      return self.makeCustomPreview(with: cell.roverLabel.text ?? "", and: cell.roverImageView.image)
    } actionProvider: { _ in
      UIMenu(title: "", identifier: nil, children: [favorite])
    }
    
    return configuration
  }
  
  private func makeCustomPreview(with text: String, and image: UIImage?) -> UIViewController {
    lazy var imageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.roundCorners(.allCorners, radius: 20)
      imageView.clipsToBounds = true
      
      return imageView
    }()
    //********//
    let vc = UIViewController()
    vc.preferredContentSize = CGSize(width: 300, height: 300)
    vc.view.backgroundColor = .yellow
    
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 10
    
    let label = UILabel()
    label.text = text
    label.textAlignment = .center
    label.font = AppFont.font(type: .bold, size: 16)
    label.textColor = .label
    label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    stack.addArrangedSubview(label)
    
    if let image = image {
      imageView.image = image
      imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
      stack.addArrangedSubview(imageView)
    }
    
    vc.view.addSubview(stack)
    stack.fillToSuperview(sideIndent: 10)
    stack.clipsToBounds = true
    
    return vc
  }
}

//MARK: - Heplers
extension MarsRoverPhotosViewController {
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

//MARK: - LOGIC
extension MarsRoverPhotosViewController {
  private func setDataSource() {
    for roverObj in self.tempDataSource {
      let newRover = RoverInfo(roverName: roverObj.name, cameraNames: roverObj.cameras.map{$0.full_name}, dateStr: roverObj.launch_date + " - " + roverObj.max_date, imageURL: nil)
      correctDataSource.append(newRover)
    }
  }
  
  private func availiableRover() {
    
  }
  private func availiableCamera() {
    
  }
  private func availiableDateRange() {
    self.roverDatePicker.minimumDate
    self.roverDatePicker.minimumDate
  }
}

//MARK: - DataSource struct
struct RoverInfo {
  let roverName: String
  let cameraNames: [String]
  let dateStr: String
  let imageURL: URL?
}
