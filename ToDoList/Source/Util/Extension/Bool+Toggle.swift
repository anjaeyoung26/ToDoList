//
//  Bool+Toggle.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/12.
//  Copyright © 2020 안재영. All rights reserved.
//

import Foundation

extension Bool {
  mutating func toggle() {
    self = !self
  }
}
