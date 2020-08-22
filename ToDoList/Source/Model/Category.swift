//
//  Category.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/07.
//  Copyright © 2020 안재영. All rights reserved.
//

import Foundation
import UIKit

enum Category: String, CaseIterable {
  case email = "SendEmail"
  case call = "MakeCall"
  case shopping = "Shopping"
  case reading = "Reading"
  case travel = "Travel"
  case study = "Study"
  case work = "Work"
  case idea = "Idea"
  case etc = "Etc"
}

func getColor(about category: String) -> UIColor? {
  switch category {
  case "SendEmail" :
    return Color.Category.sendEmail
  case "MakeCall" :
    return Color.Category.makeCall
  case "Shopping" :
    return Color.Category.shopping
  case "Reading" :
    return Color.Category.reading
  case "Travel" :
    return Color.Category.travel
  case "Study" :
    return Color.Category.study
  case "Work" :
    return Color.Category.work
  case "Idea" :
    return Color.Category.idea
  case "Etc" :
    return Color.Category.etc
  default :
    return nil
  }
}

func getImage(about category: String) -> UIImage? {
  switch category {
  case "SendEmail" :
    return SFSymbols.sendEmail
  case "MakeCall" :
    return SFSymbols.makeCall
  case "Shopping" :
    return SFSymbols.shopping
  case "Reading" :
    return SFSymbols.reading
  case "Travel" :
    return SFSymbols.travel
  case "Study" :
    return SFSymbols.study
  case "Work" :
    return SFSymbols.work
  case "Idea" :
    return SFSymbols.idea
  case "Etc" :
    return SFSymbols.etc
  default :
    return nil
  }
}
