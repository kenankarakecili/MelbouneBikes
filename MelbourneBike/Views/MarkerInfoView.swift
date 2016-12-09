//
//  MarkerInfoView.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 21/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class MarkerInfoView: UIView {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  class func instanceFromNib() -> MarkerInfoView {
    return UINib(nibName: "MarkerInfoView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MarkerInfoView
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.3
  }
  
}
