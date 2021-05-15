//
//  AllTasksCell.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/06.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

class AllTasksCell: BaseTableViewCell {
  
  let subView = UIView().then {
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.backgroundColor = .white
  }
  
  let categorySubView = UIView().then {
    $0.layer.cornerRadius = 5
    $0.layer.masksToBounds = true
    $0.backgroundColor = .white
  }
  
  let lblCategory = UILabel().then {
    $0.font = Font.Helvetica.bold(size: 13)
    $0.textColor = .white
  }
  
  let lblTitle = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 18)
    $0.textColor = .black
    $0.numberOfLines = 0
  }
  
  let imgViewCheckMark = UIImageView().then {
    $0.image = SFSymbols.checkMarkCircle
    $0.tintColor = .gray
  }
  
  let lblDate = UILabel().then {
    $0.font = Font.Helvetica.bold(size: 13)
    $0.textColor = .gray
  }
  
  let lblDescription = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 14)
    $0.textColor = .lightGray
    $0.numberOfLines = 0
  }
  
  let bgColorView = UIView().then {
    $0.backgroundColor = .white
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectedBackgroundView = bgColorView
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func prepareForReuse() {
    self.lblCategory.text = nil
    self.lblTitle.attributedText = nil
    self.lblTitle.text = nil
    self.lblDate.text = nil
    self.lblDescription.text = nil
  }
  
  override func addSubview() {
    [subView, categorySubView, lblCategory, lblTitle, lblDate, lblDescription, imgViewCheckMark].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    subView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-12)
    }
    
    categorySubView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(5)
      make.left.equalTo(lblCategory.snp.left).offset(-5)
      make.right.equalTo(lblCategory.snp.right).offset(5)
      make.height.equalTo(22)
    }
    
    lblCategory.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(10)
    }
    
    lblTitle.snp.makeConstraints { make in
      make.top.equalTo(lblCategory.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
    }
    
    imgViewCheckMark.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(38)
      make.right.equalToSuperview().offset(-15)
    }
    
    lblDate.snp.makeConstraints { make in
      make.top.equalTo(lblTitle.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
    }
    
    lblDescription.snp.makeConstraints { make in
      make.top.equalTo(lblDate.snp.bottom).offset(18)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(-10)
      make.bottom.lessThanOrEqualToSuperview()
    }
  }
  
  func configure(with task: Task) {
    guard let isDescriptionEmpty = task.description?.isEmpty,
      let color = getColor(about: task.category!) else { return }
    
    lblCategory.textColor = color
    
    lblDescription.text = isDescriptionEmpty ? "No Description" : task.description
    lblCategory.text = task.category
    lblDate.text = task.date
    
    imgViewCheckMark.isHidden = !task.isCompleted!
    
    if task.isCompleted! {
      lblTitle.attributedText = task.title!.setMiddleLine()
    } else {
      lblTitle.text = task.title
    }
  }
}
