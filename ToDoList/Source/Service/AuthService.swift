//
//  AuthService.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/14.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase
import FBSDKLoginKit
import GoogleSignIn
import RxSwift
import RxCocoa

protocol AuthServiceProtocol {
  func signUp(with email: String, _ name: String, _ password: String, _ conformPassword: String) -> Observable<ServiceResult>
  func signInWithEmail(email: String, password: String) -> Observable<ServiceResult>
  func signInWithGoogle(authentication: GIDAuthentication) -> Observable<ServiceResult>
  func signInWithFacebook(accessToken: AccessToken) -> Observable<ServiceResult>
  func sendPasswordResetEmail(email: String) -> Observable<ServiceResult>
  func signOut(providerData: UserInfo) -> Observable<ServiceResult>
}

class AuthService: AuthServiceProtocol {
  
  let reference: DatabaseReference = Database.database().reference().child("users")
  
  func signInWithEmail(email: String, password: String) -> Observable<ServiceResult> {
    return Observable.create { observer -> Disposable in
      Auth.auth().signIn(withEmail: email, password: password) { auth, error in
        error != nil ? observer.onNext(.failure(error! as NSError)) : observer.onNext(.success)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func signInWithGoogle(authentication: GIDAuthentication) -> Observable<ServiceResult> {
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    
    return Observable.create { observer -> Disposable in
      Auth.auth().signIn(with: credential) { auth, error in
        if let error = error as NSError? {
          observer.onNext(.failure(error))
        } else if let auth = auth, let authInfo = auth.additionalUserInfo {
          if authInfo.isNewUser {
            guard let name = auth.user.providerData.first?.displayName else { return }
            observer.onNext(self.setValueForNewUser(uid: auth.user.uid, name: name))
          } else {
            observer.onNext(.success)
          }
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func signInWithFacebook(accessToken: AccessToken) -> Observable<ServiceResult> {
    let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
    
    return Observable.create { observer -> Disposable in
      Auth.auth().signIn(with: credential) { auth, error in
        if let error = error as NSError? {
          observer.onNext(.failure(error))
        } else if let auth = auth, let authInfo = auth.additionalUserInfo {
          if authInfo.isNewUser {
            guard let name = auth.user.providerData.first?.displayName else { return }
            observer.onNext(self.setValueForNewUser(uid: auth.user.uid, name: name))
          } else {
            observer.onNext(.success)
          }
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func signOut(providerData: UserInfo) -> Observable<ServiceResult> {
    let providerID = providerData.providerID
    
    return Observable.create { observer -> Disposable in
      switch providerID {
      case "facebook.com" :
        LoginManager().logOut()
        observer.onNext(.success)
      case "google.com" :
        GIDSignIn.sharedInstance()?.signOut()
        observer.onNext(.success)
      default :
        do {
          try Auth.auth().signOut()
          observer.onNext(.success)
        } catch let error as NSError {
          observer.onNext(.failure(error))
        }
      }
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
  func signUp(with email: String, _ name: String, _ password: String, _ conformPassword: String) -> Observable<ServiceResult> {
    return Observable.create { observer -> Disposable in
      if password != conformPassword {
        observer.onNext(.notice(.isNotMatch))
        return Disposables.create()
      }
      Auth.auth().createUser(withEmail: email, password: password) { user, error in
        if let error = error as NSError? {
          observer.onNext(.failure(error))
        } else if let uid = user?.user.uid {
          observer.onNext(self.setValueForNewUser(uid: uid, name: name))
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func sendPasswordResetEmail(email: String) -> Observable<ServiceResult> {
    return Observable.create { observer -> Disposable in
      Auth.auth().sendPasswordReset(withEmail: email) { error in
        error == nil ? observer.onNext(.success) : observer.onNext(.failure(error! as NSError))
      }
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
  func setValueForNewUser(uid: String, name: String) -> ServiceResult {
    var setValueError: NSError?
    self.reference.child(uid).setValue(["uid" : uid, "name" : name]) { error, reference in
      if let error = error as NSError? {
        setValueError = error
      }
    }
    return setValueError != nil ? ServiceResult.failure(setValueError!) : ServiceResult.success
  }
}


