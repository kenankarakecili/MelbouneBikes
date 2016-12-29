//
//  MBAPI.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 20/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import Foundation

class MBAPI {
  
  class func getSpots(completion: @escaping ([BikeSpotStruct]) -> Void) {
    ConnectionHandler.requestGetConnection(urlString: url) { (json, status) in
      let results = unwrapArray(array: json as! [AnyObject]?)
      var itemsToReturn: [BikeSpotStruct] = []
      for result in results {
        let coordinatesDic = unwrapDictionary(dic: result["coordinates"] as Any)
        let coordinatesArray = unwrapArray(array: coordinatesDic["coordinates"] as! [AnyObject]?)
        let coordinates = Coordinates(lat: coordinatesArray.last as! Double,
                                      long: coordinatesArray.first as! Double)
        
        let item = BikeSpotStruct(id: unwrapString(str: result["id"] as Any),
                                  featurename: unwrapString(str: result["featurename"] as Any),
                                  terminalname: unwrapString(str: result["terminalname"] as Any),
                                  nbbikes: unwrapString(str: result["nbbikes"] as Any),
                                  nbemptydoc: unwrapString(str: result["nbemptydoc"] as Any),
                                  uploaddate: unwrapString(str: result["uploaddate"] as Any),
                                  coordinates: coordinates)
        itemsToReturn.append(item)
      }
      completion(itemsToReturn)
    }
  }
  
}
