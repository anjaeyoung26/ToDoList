//
//  User.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/18.
//  Copyright © 2020 안재영. All rights reserved.
//

import ObjectMapper

class User: Mappable {
  var name: String?
  var uid: String?
  
  required init?(map: Map) {
    //...
  }
  
  func mapping(map: Map) {
    name <- map["name"]
    uid <- map["uid"]
  }
}
