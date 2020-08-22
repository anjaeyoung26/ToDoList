//
//  CategorysCell.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/07.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

class CategorysCell: BaseCollectionViewCell {
  let imgViewCategory = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .white
  }
  
  let lblTitle = UILabel().then {
    $0.font = Font.Avenir.bold(size: 25)
    $0.textColor = .white
    $0.sizeToFit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func addSubview() {
    self.addSubview(imgViewCategory)
    self.addSubview(lblTitle)
  }
  
  override func setConstraints() {
    imgViewCategory.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(35)
      make.centerX.equalToSuperview()
      make.height.equalTo(self.frame.height / 3)
      make.width.equalTo(self.frame.width / 3)
    }
    
    lblTitle.snp.makeConstraints { make in
      make.top.equalTo(imgViewCategory.snp.bottom).offset(23)
      make.centerX.equalToSuperview()
      make.bottom.lessThanOrEqualToSuperview()
    }
  }
  
  func configure(category: String) {
    guard let color = getColor(about: category),
      let image = getImage(about: category) else { return }

    self.backgroundColor = color
    
    imgViewCategory.image = image
    lblTitle.text = category
  }
}
