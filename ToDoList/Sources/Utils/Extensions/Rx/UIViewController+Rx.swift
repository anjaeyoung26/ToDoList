//
//  UIViewController+Rx.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/27.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
  var viewDidLoad: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
    return ControlEvent(events: source)
  }
  
  var viewDidAppear: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { _ in }
    return ControlEvent(events: source)
  }
}
