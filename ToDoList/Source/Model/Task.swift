//
//  Task.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/18.
//  Copyright © 2020 안재영. All rights reserved.
//

import ObjectMapper
import UIKit

class Task: Mappable {
  var title: String?
  var category: String?
  var date: String?
  var description: String?
  var startTime: String?
  var endTime: String?
  var isCompleted: Bool?
  
  var isExpanded = false
  
  required init?(map: Map) {
    //...
  }
  
  func mapping(map: Map) {
    title <- map["title"]
    category <- map["category"]
    date <- map["date"]
    description <- map["description"]
    startTime <- map["startTime"]
    endTime <- map["endTime"]
    isCompleted <- map["complete"]
  }
}

extension Task: Equatable {
  static func == (lhs: Task, rhs: Task) -> Bool {
    return lhs.title == rhs.title
  }
}
