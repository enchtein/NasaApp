//
//  UserPromptViewController.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-08.
//

import UIKit

class UserPromptViewController: BaseViewController {
  
  //*******************************
  let promptInfo: UserPromptInfo
  lazy var imagesArray = self.promptInfo.imageNames
  init(promptInfo: UserPromptInfo) {
    self.promptInfo = promptInfo
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //*******************************
  var photoIndex: Int!
  
  private lazy var promptImageView: UIImageView = {
    let promptImageView = UIImageView(image: UIImage(named: self.promptInfo.imageNames.first ?? ""))
    promptImageView.contentMode = .scaleAspectFill
    return promptImageView
  }()
  private lazy var promptTextView = UITextView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func languageDidChange() {
    promptTextView.text = self.promptInfo.text
  }
  override func setupFont() {
    let fontSize = UIDevice.isTablet ? 25 : 16
    promptTextView.font = AppFont.font(type: .standart, size: fontSize)
  }
  override func setupColorTheme() {
    promptTextView.backgroundColor = .clear
  }
  
  private func setupUI() {
    self.view.addSubview(promptImageView)
    
    promptImageView.translatesAutoresizingMaskIntoConstraints = false
    promptImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
    promptImageView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
    promptImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    promptImageView.widthAnchor.constraint(equalTo: promptImageView.heightAnchor).isActive = true
    
    
    self.view.addSubview(promptTextView)
    
    promptTextView.translatesAutoresizingMaskIntoConstraints = false
    promptTextView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
    promptTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    promptTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    promptTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
    
    setAnimationForImageView()
  }
  
  private func setAnimationForImageView() {
    let firstImageName = self.imagesArray.removeFirst()
    
    UIView.transition(with: promptImageView, duration: 0.5, options: .transitionCrossDissolve) {
      self.promptImageView.image = UIImage(named: firstImageName)
    } completion: { flag in
      self.imagesArray.append(firstImageName)
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
        self?.setAnimationForImageView()
      }
    }
  }
}
