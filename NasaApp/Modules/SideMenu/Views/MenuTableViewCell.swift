//
//  MenuTableViewCell.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-15.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  @IBOutlet weak var menuIcon: UIImageView!
  @IBOutlet weak var menuTitle: UILabel!
  
  @IBOutlet weak var indicatorStack: UIStackView!
  @IBOutlet weak var indicatorTitle: UILabel!
  @IBOutlet weak var indicator: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  public func setupCell(by menuItemType: MenuItemType, isSelected: Bool) {
    menuIcon.image = menuItemType.iconImage
    menuTitle.text = menuItemType.stringValue
    
    indicatorStack.arrangedSubviews.forEach({$0.isHidden = !isSelected})
    
    self.setupFont()
    self.setupColorTheme(isSelected: isSelected)
  }
  
  private func setupFont() {
    menuTitle.font = AppFont.font(type: .standart, size: 15)
    indicatorTitle.font = AppFont.font(type: .light, size: 12)
  }
  private func setupColorTheme(isSelected: Bool) {
    let commonColor: UIColor = isSelected ? .red : .black
    menuIcon.tintColor = commonColor
    menuTitle.textColor = commonColor
  }
}
