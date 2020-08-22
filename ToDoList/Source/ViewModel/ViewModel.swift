//
//  ViewModel.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/22.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxSwift

protocol ViewModel {
  
  associatedtype Input
  associatedtype Output
  associatedtype Dependency
  
  var input: Input { get }
  var output: Output { get }
  var dependency: Dependency { get }
}

