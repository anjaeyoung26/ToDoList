//
//  ResetPasswordViewModel.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/23.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxSwift
import RxCocoa

class ResetPasswordViewModel: ViewModel {
  
  struct Input {
    let sendButtonTapped = PublishRelay<String>()
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
    
    input.sendButtonTapped
      .flatMap {
        dependency.authService.sendPasswordResetEmail(email: $0)
      }
      .bind(to: output.result)
      .disposed(by: disposeBag)
  }
}
