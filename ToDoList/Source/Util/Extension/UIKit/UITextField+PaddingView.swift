//
//  UITextField+PaddingView.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/16.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

extension UITextField {
  func leftPaddingView() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
}
