//
//  MenuItemsEnum.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-24.
//

import Foundation

enum MenuItemsEnum: String, Localizable {
  case marsRoverPhotos
  case astronomyPictureOfTheDay
  case history
  case setting
  
  var tableName: String {
    return "MenuItems"
  }
}
