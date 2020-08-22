//
//  UIViewController+UITapGesture.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/25.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

extension UIViewController {
  func dismissKeyboardOnTap() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
    self.view.addGestureRecognizer(tap)
  }
  
  @objc
  func endEditing() {
    self.view.endEditing(true)
  }
}
