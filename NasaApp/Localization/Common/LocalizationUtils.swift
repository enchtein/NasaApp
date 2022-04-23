//
//  LocalizationUtils.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-24.
//

import Foundation

struct Language {
  static let English: String = "English"
  static let Russian: String = "Русский"
}

struct PreviewLanguageCode {
  static let English: String = "en"
  static let Russian: String = "ru"
}

struct LanguageCode {
  static let English: String = "en"
  static let Russian: String = "ru"
}

public enum ApplicationLanguages: CaseIterable {
  case english
  case russian
  
  init?(id: Int) {
    switch id{
    case 1: self = .english
    case 2: self = .russian
    default: return nil
    }
  }
  
  func getTitle() -> String {
    switch self {
    case .english:
      return Language.English
    case .russian:
      return Language.Russian
    }
  }
  
  func getPreviewCode() -> String {
    switch self  {
    case .english:
      return PreviewLanguageCode.English
    case .russian:
      return PreviewLanguageCode.Russian
      
    }
  }
  
  func getCode() -> String {
    switch self {
    case .english:
      return LanguageCode.English
    case .russian:
      return LanguageCode.Russian
    }
  }
  
  static func getCodeForNotification(from code: String) -> String {
    switch code.lowercased() {
    case "en":
      return LanguageCode.English
    case "ru":
      return LanguageCode.Russian
    default:
      return LanguageCode.English
    }
  }
  
  static var current: ApplicationLanguages {
    if let targetLang = UserDefaults.standard.object(forKey: "selectedLanguage") as? String {
      return targetLang.elementsEqual("en") ? .english : .russian
    }
    return .english
  }
}

//MARK: - LocalizationUtils
class LocalizationUtils {
  
  class func setupLocalization() {
    NotificationCenter.default.addObserver(self, selector: #selector(languageWillChange(notification:)), name: NSNotification.Name.languageWillChange, object: nil)
    if let targetLang = UserDefaults.standard.object(forKey: "selectedLanguage") as? String {
      Bundle.setLanguage(targetLang)
      UserDefaults.standard.set([targetLang], forKey: "AppleLanguages")
    } else {
      let targetLang = ApplicationLanguages.english.getCode()
      UserDefaults.standard.set(targetLang, forKey: "selectedLanguage")
      Bundle.setLanguage(targetLang)
      UserDefaults.standard.set([targetLang], forKey: "AppleLanguages")
    }
    UserDefaults.standard.synchronize()
  }
  
  @objc class func languageWillChange(notification: NSNotification) {
    guard let targetLang = notification.object as? String else { return }
    debugPrint("NEW LANGUAGE: - \(targetLang) !")
    UserDefaults.standard.set(targetLang, forKey: "selectedLanguage")
    UserDefaults.standard.set([targetLang], forKey: "AppleLanguages")
    Bundle.setLanguage(targetLang)
    NotificationCenter.default.post(name: NSNotification.Name.languageDidCnahge, object: targetLang)
    UserDefaults.standard.synchronize()
  }
  
}

class ChangeLanguageHelper {
  static func change(language: ApplicationLanguages) {
    NotificationCenter.default.post(name: NSNotification.Name.languageWillChange, object: language.getCode())
  }
}
