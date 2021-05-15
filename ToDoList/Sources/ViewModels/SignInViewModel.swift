//
// SignInViewModel.swift
// ToDoList
//
// Created by 안재영 on 2020/07/22.
// Copyright © 2020 안재영. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class SignInViewModel: ViewModel {
  
  struct Input {
    let loggedInUser = PublishRelay<FirebaseAuth.User>()
    let emailLogin = PublishRelay<(email: String, password: String)>()
    let facebookLogin = PublishRelay<AccessToken>()
    let googleLogin = PublishRelay<GIDAuthentication>()
  }
  
  struct Output {
    let loginResult = PublishRelay<ServiceResult>()
    let signOutResult = PublishRelay<ServiceResult>()
  }
  
  struct Dependency {
    let authService: AuthServiceType
  }

  let input = Input()
  let output = Output()
  let disposeBag = DisposeBag()
  
  let dependency: Dependency
  
  init(dependency: Dependency) {
    self.dependency = dependency
    
    let loggedInUser = input.loggedInUser.compactMap { $0.providerData.first }
    
    loggedInUser
      .flatMap {
        dependency.authService.signOut(providerData: $0)
      }
      .bind(to: output.signOutResult)
      .disposed(by: disposeBag)
    
    input.emailLogin
      .flatMap {
        dependency.authService.signInWithEmail(email: $0, password: $1)
      }
      .bind(to: output.loginResult)
      .disposed(by: disposeBag)
    
    input.facebookLogin
      .flatMap {
        dependency.authService.signInWithFacebook(accessToken: $0)
      }
      .bind(to: output.loginResult)
      .disposed(by: disposeBag)
    
    input.googleLogin
      .flatMap {
        dependency.authService.signInWithGoogle(authentication: $0)
      }
      .bind(to: output.loginResult)
      .disposed(by: disposeBag)
  }
}
