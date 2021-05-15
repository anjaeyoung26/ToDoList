//
//  BaseViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/23.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubview()
    setConstraints()
    binding()
    
    view.backgroundColor = .white
  }
  
  func addSubview() {
  }
  
  func setConstraints() {
  }
  
  func binding() {
  }
}
