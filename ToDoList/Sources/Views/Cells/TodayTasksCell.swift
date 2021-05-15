//
//  TodayTasksCell.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/05.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

class TodayTasksCell: BaseCollectionViewCell {
  
  let imgViewCategory = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 5
    $0.tintColor = .white
  }
  
  let imgViewCheckMark = UIImageView().then {
    $0.image = SFSymbols.checkMarkCircle
    $0.tintColor = .lightGray
  }
  
  let lblTitle = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 19)
    $0.textAlignment = .center
    $0.textColor = .black
    $0.numberOfLines = 0
  }
  
  let lblDate = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 13)
    $0.textColor = .gray
  }
  
  let lblDescription = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 16)
    $0.textColor = .darkGray
    $0.numberOfLines = 0
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func prepareForReuse() {
    self.imgViewCategory.image = nil
    self.lblTitle.attributedText = nil
    self.lblDate.text = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func addSubview() {
    [imgViewCategory, imgViewCheckMark, lblDate, lblTitle, lblDescription].forEach { self.addSubview($0) }
  }
  
  override func setConstraints() {
    imgViewCategory.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview().offset(15)
    }
    
    imgViewCheckMark.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
    }
    
    lblDate.snp.makeConstraints { make in
      make.top.equalTo(lblTitle.snp.bottom).offset(5)
      make.left.equalTo(imgViewCategory.snp.right).offset(15)
    }
    
    lblTitle.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(15)
      make.left.equalTo(imgViewCategory.snp.right).offset(15)
    }
    
    lblDescription.snp.makeConstraints { make in
      make.top.equalTo(imgViewCategory.snp.bottom).offset(23)
      make.left.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
    }
  }
  
  func configure(with task: Task) {
    guard let isDescriptionEmpty = task.description?.isEmpty,
      let color = getColor(about: task.category!),
      let image = getImage(about: task.category!) else { return }
    
    lblDescription.text = isDescriptionEmpty ? "No Description" : task.description
    lblDate.text = "\(task.startTime!) - \(task.endTime!)"
    
    imgViewCheckMark.isHidden = !task.isCompleted!
    imgViewCategory.tintColor = color
    imgViewCategory.image = image
    
    if task.isCompleted! {
      lblTitle.attributedText = task.title!.setMiddleLine()
    } else {
      lblTitle.text = task.title
    }
  }
}
