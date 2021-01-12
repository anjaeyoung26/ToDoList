//
//  SCLAlertView+GIDSignInError.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/10.
//  Copyright © 2020 안재영. All rights reserved.
//

import GoogleSignIn

extension GIDSignInErrorCode {
  
  static func show(_ error: NSError) {
    switch GIDSignInErrorCode(rawValue: error.code) {
    case .unknown:
      SCLAlert.present(title: "ERROR", subTitle: "Unknown Error has been occured", style: .error)
      
    case .keychain:
      SCLAlert.present(title: "ERROR", subTitle: "Keychain Error", style: .error)
      
    case .hasNoAuthInKeychain:
      SCLAlert.present(title: "ERROR", subTitle: "Auth has no Key chain", style: .error)
      
    case .EMM:
      SCLAlert.present(title: "ERROR", subTitle: "Enterprise Mobility Management Error", style: .error)
      
    case .canceled:
      return
      
    default :
      SCLAlert.present(title: "ERROR", subTitle: "Unknown Error has been occured", style: .error)
    }
  }
}
