//
//  DescriptionViewModel.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/24.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxSwift
import RxCocoa

class DescriptionViewModel: ViewModel {
  
  struct Input {
    let date = PublishRelay<String>()
    let title = PublishRelay<String>()
    let endTime = PublishRelay<String>()
    let category = PublishRelay<String>()
    let startTime = PublishRelay<String>()
    let description = PublishRelay<String>()
    
    let addButtonTapped = PublishRelay<Void>()
  }
  
  struct Output {
    let validateResult = BehaviorRelay<Bool>(value: false)
    let addResult = PublishRelay<ServiceResult>()
  }
  
  struct Dependency {
    let taskService: TaskServiceProtocol
  }

  let input = Input()
  let output = Output()
  let disposeBag = DisposeBag()
  
  let dependency: Dependency
  
  init(dependency: Dependency) {
    self.dependency = dependency
    
    input.addButtonTapped
      .withLatestFrom(Observable.combineLatest(input.title, input.date, input.startTime, input.endTime, input.description, input.category))
      .map(asDictionary)
      .flatMap {
        dependency.taskService.add($0)
      }
      .bind(to: output.addResult)
      .disposed(by: disposeBag)
    
    Observable.combineLatest(input.title, input.date, input.startTime, input.endTime)
      .map(validate)
      .bind(to: output.validateResult)
      .disposed(by: disposeBag)
  }
  
  func validate(_ title: String, _ date: String, _ startTime: String, _ endTime: String) -> Bool {
    return title.hasCharacters() && !date.isBlank && !startTime.isBlank && !endTime.isBlank
  }
  
  func asDictionary(_ title: String, _ date: String, _ startTime: String, _ endTime: String, _ description: String, _ category: String) -> [String:Any] {
    return [
      "title": title,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "description": description,
      "category": category,
      "complete": false
    ]
  }
}
