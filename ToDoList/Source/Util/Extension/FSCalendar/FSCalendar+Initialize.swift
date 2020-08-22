//
//  FSCalendar+Initialize.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/07.
//  Copyright © 2020 안재영. All rights reserved.
//

import FSCalendar

extension FSCalendar {
  convenience init(scope: FSCalendarScope) {
    self.init()
    self.select(today)
    self.scrollDirection = .horizontal
    self.allowsMultipleSelection = false
    self.allowsSelection = true
    self.scope = scope
    
    self.appearance.do {
      $0.todayColor = .none
      $0.selectionColor = .white
      $0.todaySelectionColor = .white
      $0.headerTitleColor = .darkGray
      $0.weekdayTextColor = .darkGray
      $0.titleTodayColor = .darkGray
      $0.titleDefaultColor = .darkGray
      $0.titleSelectionColor = .darkGray
      
      $0.titleFont = Font.Avenir.bold(size: 18)
      $0.weekdayFont = Font.Helvetica.bold(size: 16)
      $0.headerTitleFont = Font.System.bold(size: 18)
      
      $0.headerMinimumDissolvedAlpha = 0.0
    }
  }}


