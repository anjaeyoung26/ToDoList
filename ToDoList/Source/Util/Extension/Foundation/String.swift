//
//  String.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/07.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

extension String {
  
  var isBlank: Bool {
    return trimmingCharacters(in: .whitespaces).isEmpty
  }
  
  func hasCharacters() -> Bool {
    do {
      let regex = try NSRegularExpression(pattern: "[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]$", options: .caseInsensitive)
      if let _ = regex.firstMatch(in: self, options: [NSRegularExpression.MatchingOptions.reportCompletion], range: NSMakeRange(0, self.count)){
        return true
      }
    } catch {
      print(error.localizedDescription)
      return false
    }
    return false
  }
  
  func isEmailForm() -> Bool {
    do {
      let regex = try NSRegularExpression(pattern: "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}", options: .caseInsensitive)
      if let _ = regex.firstMatch(in: self, options: [NSRegularExpression.MatchingOptions.reportCompletion], range: NSMakeRange(0, self.count)) {
        return true
      }
    } catch {
      print(error.localizedDescription)
      return false
    }
    return false
  }
  
  func setMiddleLine() -> NSAttributedString {
    let attributeString =  NSMutableAttributedString(string: self)
    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
    return attributeString
  }
}
