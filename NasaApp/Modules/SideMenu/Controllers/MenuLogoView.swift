//
//  MenuLogoView.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-16.
//

import UIKit

class MenuLogoView: UIView {
  init() {
    super.init(frame: .zero)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    self.addSubview(logoImageView)
    self.addSubview(self.createdBy)
  }
  //MARK: - UI Components
  lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "ic_nasa")
    
    return imageView
  }()
  lazy var createdBy = CreatedBy(imageViewSideSize: 20)
  
  //MARK: - Setup Constraints
  func setupMenuLogoViewConstraints() {
    [logoImageView, createdBy].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
    
    logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
    logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
    logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor).isActive = true
    
    createdBy.leadingAnchor.constraint(greaterThanOrEqualTo: self.logoImageView.trailingAnchor, constant: 15).isActive = true
    createdBy.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    createdBy.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
}
