//
//  URLSession+Extensions.swift
//  NasaApp
//
//  Created by Track Ensure on 2022-06-12.
//

import UIKit

extension URLSession {
  static private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
  
  static func downloadImage(from path: String, completion: @escaping (_ image: UIImage?) -> Void) {
    guard let url = URL(string: path) else { completion(nil); return }
      print("Download Started")
      getData(from: url) { data, response, error in
        guard let data = data, error == nil else { completion(nil); return }
          print(response?.suggestedFilename ?? url.lastPathComponent)
          print("Download Finished")
          // always update the UI from the main thread
          DispatchQueue.main.async() {
            completion(UIImage(data: data))
          }
      }
  }
}
