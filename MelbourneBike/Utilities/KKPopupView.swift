//
//  KKPopupView().swift
//
//  Created by Kenan Karakecili on 15/06/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class KKPopupView {
  
  static let shared = KKPopupView()
  private init() {}
  
  func showView(view: UIView) {
    guard let window = UIApplication.shared.keyWindow else { return }
    let curtainFrame = CGRect(x: 0,
                              y: 0,
                              width: window.frame.width,
                              height: window.frame.height)
    let curtainView = UIView(frame: curtainFrame)
    curtainView.backgroundColor = UIColor.black
    curtainView.alpha = 0.0
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(dismissView))
    curtainView.addGestureRecognizer(tapGesture)
    curtainView.tag = 19121988
    window.addSubview(curtainView)
    view.alpha = 0.0
    view.tag = 19881219
    view.layer.cornerRadius = 3.0
    window.addSubview(view)
    window.bringSubview(toFront: curtainView)
    window.bringSubview(toFront: view)
    UIView.animate(withDuration: 0.2) {
      curtainView.alpha = 0.0
      view.alpha = 1.0
    }
  }
  
  @objc func dismissView() {
    guard let window = UIApplication.shared.keyWindow else { return }
    let curtainView = window.viewWithTag(19121988)
    let view = window.viewWithTag(19881219)
    guard let myCurtainView = curtainView else { return }
    guard let myView = view else { return }
    NotificationCenter.default.removeObserver(self)
    UIView.animate(withDuration: 0.1, animations: {
      myCurtainView.alpha = 0.0
      myView.alpha = 0.0
      }) { (finished) in
        myCurtainView.removeFromSuperview()
        myView.removeFromSuperview()
    }
  }
  
}
