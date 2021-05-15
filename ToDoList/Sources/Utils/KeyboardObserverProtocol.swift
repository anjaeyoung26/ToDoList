//
//  KeyboardObserverProtocol.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/16.
//  Copyright © 2020 안재영. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardObserverProtocol {
  func register(for object: AnyObject)
  func register()
  func remove()

  var center: NotificationCenter { get }
}

extension KeyboardObserverProtocol {
  var center: NotificationCenter {
    return NotificationCenter.default
  }
}

extension KeyboardObserverProtocol where Self: UIViewController {
  func register(for object: AnyObject) {
    center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
      if object.isFirstResponder {
        self.keyboardWillShow(notification: notification)
      }
    }
    center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
      self.keyboardWillHide(notification: notification)
    }
  }
  
  func register() {
    center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
      self.keyboardWillShow(notification: notification)
    }
    center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
      self.keyboardWillHide(notification: notification)
    }
  }
  
  func remove() {
    center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillShow(notification: Notification) {
    if notification.keyboardHeight == 0.0 || self.view.frame.origin.y != 0 {
      return
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.frame.origin.y -= notification.keyboardHeight - (self.view.frame.height * 0.1)
    })
  }
  
  func keyboardWillHide(notification: Notification) {
    if self.view.frame.origin.y == 0 {
      return
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.frame.origin.y = 0
    })
  }
}
