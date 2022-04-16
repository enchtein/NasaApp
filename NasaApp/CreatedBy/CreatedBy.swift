//
//  CreatedBy.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-16.
//

import UIKit

class CreatedBy: UIStackView {
  private let imageViewSideSize: CGFloat
  private var createdByLabelFontSize: Int {
    return Int(imageViewSideSize * 0.9)
  }
  
  init(imageViewSideSize: CGFloat) {
    self.imageViewSideSize = imageViewSideSize
    
    super.init(frame: .zero)
    
    self.setupUI()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var createdByImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = false
    imageView.image = UIImage(named: "ic_instagram")
    imageView.tintColor = .red
    
    return imageView
  }()
  
  lazy var createdByTitle: UILabel = {
    let label = UILabel()
    label.isUserInteractionEnabled = true
    label.font = AppFont.font(type: .bold, size: createdByLabelFontSize)
    label.textColor = .red
    label.text = "enchtein"
    
    return label
  }()
  
  private func setupUI() {
    self.axis = .horizontal
    self.spacing = 5
    self.alignment = .center
    self.distribution = .fill
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(createdByAction(_:)))
    self.addGestureRecognizer(tapGesture)
    
    self.addArrangedSubview(createdByImageView)
    self.addArrangedSubview(createdByTitle)
    
    
    createdByImageView.translatesAutoresizingMaskIntoConstraints = false
    createdByImageView.widthAnchor.constraint(equalToConstant: imageViewSideSize).isActive = true
    createdByImageView.heightAnchor.constraint(equalToConstant: imageViewSideSize).isActive = true
  }
  
  @objc private func createdByAction(_ gesture: UITapGestureRecognizer) {
    print("tapped createdBy StackView")
  }
}
