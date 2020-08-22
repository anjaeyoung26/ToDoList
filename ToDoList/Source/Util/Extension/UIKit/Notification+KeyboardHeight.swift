//
//  Notification+KeyboardHeight.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/25.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

extension Notification {
  var keyboardHeight: CGFloat {
    return (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 50
  }
}
