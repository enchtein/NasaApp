//
//  Notification.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-04-14.
//

import UIKit

extension Notification.Name {
  static let languageDidCnahge = Notification.Name("LANGUAGE_DID_CHANGE")
  static let languageWillChange = Notification.Name("LANGUAGE_WILL_CHANGE")
}

extension Notification.Name {
  func post(center: NotificationCenter = NotificationCenter.default,
            object: Any? = nil,
            userInfo: [AnyHashable : Any]? = nil) {
    center.post(name: self, object: object, userInfo: userInfo)
  }
  
  func onPost(center: NotificationCenter = NotificationCenter.default,
              object: Any? = nil, queue: OperationQueue? = nil,
              using: @escaping (Notification) -> Void) -> NSObjectProtocol {
    return center.addObserver(forName: self, object: object,
                              queue: queue, using: using)
  }
}

extension Notification {
  static func removeObservers(observers: [Any], center: NotificationCenter = NotificationCenter.default) {
    for observer in observers {
      center.removeObserver(observer)
    }
  }
}
