//
//  BaseCollectionViewCell.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/23.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.do {
      $0.backgroundColor = .white
      $0.layer.cornerRadius = 20
      $0.layer.masksToBounds = true
    }
    
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
