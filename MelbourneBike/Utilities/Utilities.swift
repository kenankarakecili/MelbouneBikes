//
//  Utilities.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 20/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

func unwrapString(str: Any?) -> String {
  if let str = str as? String {
    return str
  }
  return ""
}

func unwrapArray(array: [AnyObject]?) -> [AnyObject] {
  if let myArray = array {
    return myArray
  }
  return []
}

func unwrapDictionary(dic: Any?) -> [String: AnyObject] {
  if let myDic = dic as? [String: AnyObject] {
    return myDic
  }
  return [:]
}

func fontRegular(size: Int) -> UIFont {
  return UIFont.systemFont(ofSize: CGFloat(size))
}

extension String {
  
  func toInt() -> Int {
    if let myNumber = NumberFormatter().number(from: self) {
      return Int(myNumber)
    }
    return 0
  }
  
  func toDouble() -> Double {
    if let myNumber = NumberFormatter().number(from: self) {
      return Double(myNumber)
    }
    return 0.0
  }
  
}

extension UITextField {
  
  enum ImageSide {
    case Left
    case Right
  }
  
  func addImage(image: UIImage?, side: ImageSide) {
    let subview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
    let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 16.0))
    imageView.center = subview.center
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    subview.addSubview(imageView)
    let tap = UITapGestureRecognizer(target: self, action: #selector(startEditing))
    subview.addGestureRecognizer(tap)
    if side == .Left {
      leftViewMode = .always
      leftView = subview
    } else {
      rightViewMode = .always
      rightView = subview
    }
  }
  
  func startEditing() {
    self.becomeFirstResponder()
  }
  
  func isEmpty() -> Bool {
    return self.text == "" ? true : false
  }
  
}

extension UITableView {
  
  func reloadWithAnimation() {
    UIView.transition(with: self,
                      duration: 0.2,
                      options: .transitionCrossDissolve,
                      animations: {
                        self.reloadData()
      }, completion: nil)
  }
  
}
