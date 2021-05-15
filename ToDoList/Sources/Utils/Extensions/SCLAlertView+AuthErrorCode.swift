//
//  SCLAlertView+AuthErrorCode.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/10.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase

extension AuthErrorCode {
  
  static func show(_ error: NSError) {
    switch AuthErrorCode(rawValue: error.code) {
    case .networkError :
      SCLAlert.present(title: "ERROR", subTitle: "Please check network connection", style: .error)
      
    case .userNotFound :
      SCLAlert.present(title: "ERROR", subTitle: "Your account could not be found.", style: .error)
      
    case .userTokenExpired :
      SCLAlert.present(title: "ERROR", subTitle: "Token has expired. if you have changed password on another device, sign in again on this device.", style: .error)
      
    case .tooManyRequests :
      SCLAlert.present(title: "ERROR", subTitle: "Please try again in a moment", style: .error)
      
    case .invalidAPIKey :
      SCLAlert.present(title: "ERROR", subTitle: "Application API Key is invalid. Please inquire by this email 'dkswodud011@naver.com'", style: .error)
      
    case .appNotAuthorized :
      SCLAlert.present(title: "ERROR", subTitle: "Application API Key is invalid. Please inquire by this email 'dkswodud011@naver.com'", style: .error)
      
    case .keychainError :
      SCLAlert.present(title: "ERROR", subTitle: "Key chain error has been occured.", style: .error)
      
    case .internalError :
      SCLAlert.present(title: "ERROR", subTitle: "Internal error has benn occured.", style: .error)
      
    case .operationNotAllowed :
      SCLAlert.present(title: "ERROR", subTitle: "Please check network connection", style: .error)
      
    case .invalidEmail :
      SCLAlert.present(title: "ERROR", subTitle: "This email is invalid. Please check email you entered.", style: .error)
      
    case .userDisabled :
      SCLAlert.present(title: "ERROR", subTitle: "Your account is disabled. Please inquire by 'dkswodud011@naver.com'", style: .error)
      
    case .wrongPassword :
      SCLAlert.present(title: "ERROR", subTitle: "Wrong Password", style: .error)
      
    case .invalidCredential :
      SCLAlert.present(title: "ERROR", subTitle: "Your Credential is overdue or formatted incorrectly", style: .error)
      
    case .emailAlreadyInUse :
      SCLAlert.present(title: "ERROR", subTitle: "This email is already in use", style: .error)
      
    case .weakPassword :
      SCLAlert.present(title: "ERROR", subTitle: "The password you entered is not safe. Please enter a different password.", style: .error)
      
    default :
      SCLAlert.present(title: "ERROR", subTitle: "Error has been occured", style: .error)
    }
  }
}
