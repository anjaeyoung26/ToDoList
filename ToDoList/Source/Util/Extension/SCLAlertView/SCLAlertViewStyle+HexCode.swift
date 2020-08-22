//
//  SCLAlertViewStyle+HexCode.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/07.
//  Copyright © 2020 안재영. All rights reserved.
//

import SCLAlertView

extension SCLAlertViewStyle {
  var hexCode: UInt {
    switch self {
      case .error :
        return 0xFF0000
      case .warning :
        return 0xF9D71C
      case .info :
        return 0xC377E0
      case .success :
        return 0x008000
      case .wait :
        return 0x878787
      default :
        return 0x2f2f2f
    }
  }
}
