//
//  GoogleDelegateProxy.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/15.
//  Copyright © 2020 안재영. All rights reserved.
//

import GoogleSignIn
import RxCocoa
import RxSwift

class GoogleDelegateProxy: DelegateProxy<GIDSignIn, GIDSignInDelegate>, DelegateProxyType, GIDSignInDelegate {
  let subject = PublishSubject<(GIDGoogleUser?, Error?)>()
  
  static func registerKnownImplementations() {
    self.register { GIDSignIn -> GoogleDelegateProxy in
      GoogleDelegateProxy(parentObject: GIDSignIn, delegateProxy: GoogleDelegateProxy.self)
    }
  }
  
  static func currentDelegate(for object: GIDSignIn) -> GIDSignInDelegate? {
    return object.delegate
  }
  
  static func setCurrentDelegate(_ delegate: GIDSignInDelegate?, to object: GIDSignIn) {
    object.delegate = delegate
  }
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    subject.onNext((user, error))
  }
}

extension Reactive where Base: GIDSignIn {
  var delegate: GoogleDelegateProxy {
    return GoogleDelegateProxy.proxy(for: base)
  }
  
  var result: Observable<(GIDGoogleUser?, Error?)> {
    return delegate.subject.asObservable()
  }
}
