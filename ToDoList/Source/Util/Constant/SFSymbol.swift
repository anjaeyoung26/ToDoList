//
//  SFSymbol.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/11.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)

struct SFSymbols {
  static let signOut = UIImage(systemName: "person.crop.circle.fill.badge.minus", withConfiguration: symbolConfiguration)
  static let makeCall = UIImage(systemName: "phone.arrow.up.right", withConfiguration: symbolConfiguration)
  static let calendar = UIImage(systemName: "calendar.badge.plus",withConfiguration: symbolConfiguration)
  static let pencil = UIImage(systemName: "pencil.and.outline", withConfiguration: symbolConfiguration)
  static let clockFill = UIImage(systemName: "clock.fill", withConfiguration: symbolConfiguration)
  static let sendEmail = UIImage(systemName: "envelope", withConfiguration: symbolConfiguration)
  static let travel = UIImage(systemName: "paperplane", withConfiguration: symbolConfiguration)
  static let back = UIImage(systemName: "chevron.left", withConfiguration: symbolConfiguration)
  static let cancel = UIImage(systemName: "multiply", withConfiguration: symbolConfiguration)
  static let add = UIImage(systemName: "plus.circle", withConfiguration: symbolConfiguration)
  static let idea = UIImage(systemName: "lightbulb", withConfiguration: symbolConfiguration)
  static let shopping = UIImage(systemName: "cart", withConfiguration: symbolConfiguration)
  static let study = UIImage(systemName: "pencil", withConfiguration: symbolConfiguration)
  static let reading = UIImage(systemName: "book", withConfiguration: symbolConfiguration)
  static let etc = UIImage(systemName: "ellipsis", withConfiguration: symbolConfiguration)
  static let clock = UIImage(systemName: "clock", withConfiguration: symbolConfiguration)
  static let work = UIImage(systemName: "bag", withConfiguration: symbolConfiguration)
  static let checkMarkCircle = UIImage(systemName: "checkmark.circle")
  static let checkMark = UIImage(systemName: "checkmark")
  static let circle = UIImage(systemName: "circle")
  static let trash = UIImage(systemName: "trash")
}
