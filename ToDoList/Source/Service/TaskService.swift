//
//  TaskService.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/08.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxSwift
import RxCocoa
import Firebase

protocol TaskServiceType {
  func search(about target: Task, key completion: @escaping (String?) -> ())
  func add(_ targetDictionary: [String:Any]) -> Observable<ServiceResult>
  func fetch() -> Observable<[Task]>
  
  @discardableResult
  func complete(_ target: Task) -> Observable<Void>
  
  @discardableResult
  func delete(_ target: Task) -> Observable<Void>
}

class TaskService: TaskServiceType {
  let disposeBag = DisposeBag()
  
  var reference: DatabaseReference {
    guard let user = Auth.auth().currentUser else {
      print("Fail to get current user 🔴")
      return Database.database().reference().child("legacy")
    }
    return Database.database().reference().child("users").child(user.uid).child("tasks")
  }
  
  func fetch() -> Observable<[Task]> {
    return Observable.create { observer -> Disposable in
      let handle = self.reference.queryOrdered(byChild: "date").observe(.value, with: { snapShot in
        let task = snapShot.children
          .compactMap { ($0 as? DataSnapshot)?.value as? [String:Any] }
          .map { Task(JSON: $0) }
          .map { $0! }
        observer.onNext(task)
      })
      return Disposables.create {
        self.reference.removeObserver(withHandle: handle)
      }
    }
  }
  
  func add(_ targetDictionary: [String:Any]) -> Observable<ServiceResult> {
    guard let target = Task(JSON: targetDictionary) else { return .empty() }
    return Observable.create { observer -> Disposable in
      self.search(about: target) { key in
        if key != nil {
          observer.onNext(.notice(.isOverlapped))
          observer.onCompleted()
        } else {
          self.reference.childByAutoId().setValue(targetDictionary) { error, _ in
            error == nil ? observer.onNext(.success) : observer.onNext(.failure(error! as NSError))
            observer.onCompleted()
          }
        }
      }
      return Disposables.create()
    }
  }
  
  func search(about target: Task, key completion: @escaping (String?) -> ()) {
    self.reference.observeSingleEvent(of: .value, with:  { snapShot in
      for child in snapShot.children.allObjects as! [DataSnapshot] {
        guard let task = Task(JSON: child.value as! [String:Any]) else { return }
        if task == target { completion(child.key) }
      }
      completion(nil)
    })
  }
  
  @discardableResult
  func complete(_ target: Task) -> Observable<Void> {
    search(about: target) { key in
      if let key = key { self.reference.child(key).updateChildValues(["complete" : true]) }
    }
    return .just(Void())
  }
  
  
  @discardableResult
  func delete(_ target: Task) -> Observable<Void> {
    search(about: target) { key in
      if let key = key { self.reference.child(key).setValue(nil) }
    }
    return .just(Void())
  }
}
