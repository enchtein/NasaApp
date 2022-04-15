//
//  Menus.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-15.
//

import UIKit

enum MenuItemType: Int, CaseIterable {
  case MarsRoverPhotos = 0
  case AstronomyPictureOfTheDay // get info from api.nasa.gov
  case History
  case Setting
  
  var stringValue: String { // should localize
    switch self {
    case .MarsRoverPhotos:
      return "Mars Rover Photos"
    case .AstronomyPictureOfTheDay:
      return "Astronomy Picture of the Day"
    case .History:
      return "History"
    case .Setting:
      return "Settings"
    }
  }
  
  var iconImage: UIImage? { // should add images to assets
    switch self {
    case .MarsRoverPhotos: return UIImage(named: "ic_marsRover")
    case .AstronomyPictureOfTheDay: return UIImage(named: "ic_astronomy")
    case .History: return UIImage(named: "ic_history")
    case .Setting: return UIImage(named: "ic_settings")
    }
  }
  
  var controller: UIViewController { // should add all controllers for all windows
    switch self {
    case .MarsRoverPhotos:
      return NasaClientViewController.createFromStoryboard()
    case .AstronomyPictureOfTheDay: return UIViewController()
    case .History: return UIViewController()
    case .Setting: return UIViewController()
    }
  }
}

final class Menu {
  static let shared: Menu = Menu()
  init() {
    menuItems = []
    selectedMenuItem = .MarsRoverPhotos
    reloadMenuItems()
    selectedMenuItem = menuItems.first ?? .MarsRoverPhotos
  }
  
  var menuItems: [MenuItemType]
  var selectedMenuItem: MenuItemType
  
  var count: Int {
    return menuItems.count
  }
  
  func menuItem(with index: Int) -> MenuItemType {
    return menuItems[index]
  }
  
  func reloadMenuItems() {
    menuItems = MenuItemType.allCases
  }
}
