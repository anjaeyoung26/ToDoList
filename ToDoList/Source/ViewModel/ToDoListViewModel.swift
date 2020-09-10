//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/24.
//  Copyright © 2020 안재영. All rights reserved.
//
import RxSwift
import RxCocoa
import FirebaseAuth

class ToDoListViewModel: ViewModel {
  
  struct Input {
    let date = PublishRelay<Date>()
    let delete = PublishRelay<Task>()
    let complete = PublishRelay<Task>()
    let signOut = PublishRelay<FirebaseAuth.User>()
  }
  
  struct Output {
    let userTasks = PublishRelay<[Task]>()
    let userTasksByDate = PublishRelay<[Task]>()
    let signOutResult = PublishRelay<ServiceResult>()
  }
  
  struct Dependency {
    let taskService: TaskServiceType
    let authService: AuthServiceType
  }
  
  let input = Input()
  let output = Output()
  let disposeBag = DisposeBag()
  
  let dependency: Dependency
  
  init(dependency: Dependency) {
    self.dependency = dependency
    
    let currentDate = input.date
      .asObservable()
      .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
      }
    
    let currentUser = input.signOut
      .compactMap { $0.providerData.first }
    
    currentDate
      .flatMap { date in
        dependency.taskService.fetch().map { $0.filter { $0.date == date }}
      }
      .bind(to: output.userTasksByDate)
      .disposed(by: disposeBag)
    
    currentUser
      .flatMap {
        dependency.authService.signOut(providerData: $0)
      }
      .bind(to: output.signOutResult)
      .disposed(by: disposeBag)

    input.complete
      .do(onNext: { task in
        task.isCompleted = true
      })
      .subscribe(onNext: { task in
        dependency.taskService.complete(task)
      })
      .disposed(by: disposeBag)
    
    input.delete
      .subscribe(onNext: { task in
        dependency.taskService.delete(task)
      })
      .disposed(by: disposeBag)
    
    dependency.taskService
      .fetch()
      .bind(to: output.userTasks)
      .disposed(by: disposeBag)
  }
}
