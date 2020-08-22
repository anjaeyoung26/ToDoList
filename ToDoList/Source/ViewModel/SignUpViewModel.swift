//
//  SignUpViewModel.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/23.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxSwift
import RxCocoa

class SignUpViewModel: ViewModel {
  
  struct Input {
    let signUpButtonTapped = PublishRelay<(String, String, String, String)>()
  }
  
  struct Output {
    let result = PublishRelay<ServiceResult>()
  }
  
  struct Dependency {
    let authService: AuthServiceProtocol
  }
  
  let input = Input()
  let output = Output()
  let disposeBag = DisposeBag()
  
  let dependency: Dependency
  
  init(dependency: Dependency) {
    self.dependency = dependency
    
    input.signUpButtonTapped
      .flatMap { email, name, password, conformPassword in
        dependency.authService.signUp(with: email, name, password, conformPassword)
      }
      .bind(to: output.result)
      .disposed(by: disposeBag)
  }
}
