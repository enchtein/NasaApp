//
//  String+Extensions.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-24.
//

import UIKit

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
    
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
            let bundle = Bundle(path: path) else {
                
                return super.localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    
    class func setLanguage(_ language: String) {
        
        defer {
            object_setClass(Bundle.main, AnyLanguageBundle.self)
        }
        print(language)
        objc_setAssociatedObject(Bundle.main, &bundleKey,    Bundle.main.path(forResource: language, ofType: "lproj"), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

extension String {
  func load() -> UIImage? {
    do {
      guard let url = URL(string: self) else {return nil}
      
      let data = try Data(contentsOf: url)
      
      return UIImage(data: data)
    } catch let error {
      debugPrint(error.localizedDescription)
    }
    
    return nil
  }
}
