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
        let coordinatesDic = unwrapDictionary(dic: result["coordinates"])
        let coordinatesArray = unwrapArray(array: coordinatesDic["coordinates"] as! [AnyObject]?)
        let coordinates = Coordinates(lat: coordinatesArray.last as! Double,
                                      long: coordinatesArray.first as! Double)
        
        let item = BikeSpotStruct(id: unwrapString(str: result["id"]),
                                  featurename: unwrapString(str: result["featurename"]),
                                  terminalname: unwrapString(str: result["terminalname"]),
                                  nbbikes: unwrapString(str: result["nbbikes"]),
                                  nbemptydoc: unwrapString(str: result["nbemptydoc"]),
                                  uploaddate: unwrapString(str: result["uploaddate"]),
                                  coordinates: coordinates)
        itemsToReturn.append(item)
      }
      completion(itemsToReturn)
    }
  }
  
}
