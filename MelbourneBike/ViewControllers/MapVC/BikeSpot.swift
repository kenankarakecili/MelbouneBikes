//
//  BikeSpot.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 20/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class BikeSpot {
  
  static let shared = BikeSpot()
  var spots: [BikeSpotStruct] = []
  private init() {}
  
}

struct BikeSpotStruct {
  
  var id = ""
  var featurename = ""
  var terminalname = ""
  var nbbikes = ""
  var nbemptydoc = ""
  var uploaddate = ""
  var coordinates = Coordinates()
  let icon = UIImage(named: "img-marker")
  
}

struct Coordinates {
  var lat = 0.0
  var long = 0.0
}
