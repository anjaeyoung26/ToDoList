//
//  ServiceResult.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/02.
//  Copyright © 2020 안재영. All rights reserved.
//

import Foundation

enum ServiceResult {
  case success
  case failure(NSError)
  case notice(Message)
}

extension ServiceResult {
  enum Message: CustomStringConvertible {
    case isNotMatch
    case isOverlapped
    
    var description: String {
      switch self {
      case .isNotMatch: return "Password and conform password do not match"
      case .isOverlapped: return "Task for same title alreay exists."
      }
    }
  }
}
