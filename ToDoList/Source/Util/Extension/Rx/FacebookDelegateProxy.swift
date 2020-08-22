//
//  FacebookDelegateProxy.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/15.
//  Copyright © 2020 안재영. All rights reserved.
//

import FBSDKLoginKit
import RxCocoa
import RxSwift

class FacebookDelegateProxy: DelegateProxy<FBLoginButton, LoginButtonDelegate>, DelegateProxyType, LoginButtonDelegate {
  let subject = PublishSubject<(LoginManagerLoginResult?, Error?)>()
  
  static func registerKnownImplementations() {
    self.register { button -> FacebookDelegateProxy in
      FacebookDelegateProxy(parentObject: button, delegateProxy: FacebookDelegateProxy.self)
    }
  }
  
  static func currentDelegate(for object: FBLoginButton) -> LoginButtonDelegate? {
    return object.delegate
  }
    
  static func setCurrentDelegate(_ delegate: LoginButtonDelegate?, to object: FBLoginButton) {
    object.delegate = delegate
  }
  
  func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
    subject.onNext((result, error))
  }
  
  func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    //...
  }
}

extension Reactive where Base: FBLoginButton {
  var delegate: FacebookDelegateProxy {
    return FacebookDelegateProxy.proxy(for: base)
  }
  
  var result: Observable<(LoginManagerLoginResult?, Error?)> {
    return delegate.subject.asObservable()
  }
}
