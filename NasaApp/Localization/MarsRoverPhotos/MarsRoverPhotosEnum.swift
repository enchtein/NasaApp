//
//  MarsRoverPhotosEnum.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-24.
//

import Foundation

enum MarsRoverPhotosEnum: String, Localizable {
  case name
  case camera
  case cameras
  case date
  case from
  case to
  
  var tableName: String {
    return "MarsRoverPhotos"
  }
}
