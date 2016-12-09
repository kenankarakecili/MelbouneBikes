//
//  ConnectionHandler.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 20/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class ConnectionHandler: NSObject {
  
  enum ResponseStatus: String {
    case FAILED
    case SUCCESSFUL
  }
  
  typealias ResultJsonComp = (_: Any?, _: ResponseStatus) -> Void
  
  class func requestGetConnection(urlString: String, completion: @escaping ResultJsonComp) {
    let url = URL(string: urlString)
    var request = URLRequest(url: url!,
                             cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 60)
    request.httpMethod = "GET"
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let task = session.dataTask(with: request) { (data, response, error) in
      if let data = data {
        DispatchQueue.global(qos: .default).async {
          do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            DispatchQueue.main.async {
              completion(json, .SUCCESSFUL)
            }
          } catch {
            DispatchQueue.main.async {
              completion(nil, .FAILED)
            }
          }
        }
      } else {
        DispatchQueue.main.async {
          completion(nil, .FAILED)
        }
      }
    }
    task.resume()
  }
  
}
