//
//  BaseTableViewCell.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/23.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .white
    
    addSubview()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func addSubview() {
  }
  
  func setConstraints() {
  }
}
