//
//  UIButton+State.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/12.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

extension UIButton {
  func setEnabledState(_ isEnabled: Bool) {
    self.backgroundColor = isEnabled ? .black : Color.darkGrayish
    self.alpha = isEnabled ? 1 : 0.1
    self.isEnabled = isEnabled
  }
}
