//
//  SearchView.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 21/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
  func didSelect(row: Int)
}

class SearchView: UIView {
  
  let rowHeight = 44.0
  let maxViewHeight = 300.0
  let topSpace: CGFloat = 2.0
  
  @IBOutlet weak var tableView: UITableView!
  
  var delegate: SearchViewDelegate?
  internal var items: [String] = []
  
  class func instanceFromNib() -> SearchView {
    return UINib(nibName: "SearchView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SearchView
  }
  
  private func setBounds(field: UITextField) {
    let estimatedHeight = Double(items.count) * rowHeight
    let xValue = Double(field.frame.origin.x)
    let yValue = Double(field.frame.origin.y + field.bounds.size.height + topSpace)
    let width = Double(field.bounds.size.width)
    frame = CGRect(x: xValue,
                   y: yValue,
                   width: width,
                   height: min(maxViewHeight, estimatedHeight))
  }
  
  func setup(items: [String], field: UITextField) {
    self.items = items
    setBounds(field: field)
    tableView.reloadWithAnimation()
  }
  
}

extension SearchView: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
    if cell == nil {
      cell = UITableViewCell.init(style: .default, reuseIdentifier: "CellID")
      cell?.textLabel?.textColor = .darkGray
      cell?.textLabel?.font = fontRegular(size: 14)
      cell?.textLabel?.numberOfLines = 2
      cell?.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
    cell?.textLabel?.text = self.items[indexPath.row]
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    delegate?.didSelect(row: indexPath.row)
  }
  
}
