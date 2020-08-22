//
//  SCLAlert.swift
//  ToDoList
//
//  Created by 안재영 on 2020/06/27.
//  Copyright © 2020 안재영. All rights reserved.
//

import SCLAlertView

class SCLAlert {
  
  typealias Action = () -> Void
  
  struct Constant {
    static let titleTop: CGFloat = 40
    static let buttonRadius: CGFloat = 10
    static let titleFont = Font.Avenir.bold(size: 18)
    static let textFont = Font.System.nomal(size: 15)
    static let buttonFont = Font.System.bold(size: 16)
    static let windowWidth = (UIScreen.main.bounds.width / 1.5) + 23
  }
  
  struct Appearance {
    static let basic = SCLAlertView.SCLAppearance(
      kTitleTop : Constant.titleTop,
      kTitleFont : Constant.titleFont,
      kTextFont : Constant.textFont,
      kButtonFont : Constant.buttonFont,
      showCloseButton : false,
      hideWhenBackgroundViewIsTapped: true
    )
    
    static let oneButton = SCLAlertView.SCLAppearance(
      kTitleTop : Constant.titleTop,
      kTitleFont : Constant.titleFont,
      kTextFont : Constant.textFont,
      kButtonFont : Constant.buttonFont,
      showCloseButton : false,
      buttonCornerRadius : Constant.buttonRadius
    )
    
    static let twoButton = SCLAlertView.SCLAppearance(
      kTitleTop : Constant.titleTop,
      kTitleFont : Constant.titleFont,
      kTextFont : Constant.textFont,
      kButtonFont : Constant.buttonFont,
      showCloseButton : false,
      showCircularIcon: false,
      buttonCornerRadius : Constant.buttonRadius,
      buttonsLayout: .horizontal
    )
    
    static let timePicker = SCLAlertView.SCLAppearance(
      kTitleTop : Constant.titleTop,
      kTitleFont : Constant.titleFont,
      kButtonFont : Constant.buttonFont,
      showCloseButton : false,
      showCircularIcon: false
    )
    
    static let datePicker = SCLAlertView.SCLAppearance(
      kTitleTop : Constant.titleTop,
      kWindowWidth: Constant.windowWidth,
      kTitleFont : Constant.titleFont,
      kButtonFont : Constant.buttonFont,
      showCloseButton : false,
      showCircularIcon: false
    )
  }
  
  static func present(title: String, subTitle: String, style: SCLAlertViewStyle) {
    let appearance = Appearance.basic
    
    DispatchQueue.main.async {
      SCLAlertView(appearance: appearance).showTitle(title, subTitle : subTitle, timeout: .none, completeText : "", style : style, colorStyle : style.hexCode, colorTextButton : 0xFFFFFF, animationStyle : .noAnimation)
    }
  }
  
  static func present(target: UIViewController, title: String, subTitle: String, buttonText: String, buttonSelector: Selector, style: SCLAlertViewStyle) {
    let appearance = Appearance.oneButton
    
    let alert = SCLAlertView(appearance: appearance)
    alert.addButton(buttonText, target: target, selector: buttonSelector)
    
    DispatchQueue.main.async {
      alert.showTitle(title, subTitle : subTitle, style : style, timeout : .none, colorStyle : style.hexCode, colorTextButton : 0xFFFFFF, animationStyle : .noAnimation)
    }
  }
  
  static func present(target: UIViewController, title: String, subTitle: String, FirstbuttonText: String, FirstbuttonSelector: Selector, SecondbuttonText: String, SecondbuttonSelector: Selector, style: SCLAlertViewStyle) {
    let appearance = Appearance.twoButton
    
    let alert = SCLAlertView(appearance: appearance)
    alert.addButton(FirstbuttonText, target: target, selector: FirstbuttonSelector)
    alert.addButton(SecondbuttonText, target: target, selector: SecondbuttonSelector)
    
    DispatchQueue.main.async {
      alert.showTitle(title, subTitle : subTitle, style : style, timeout : .none, colorStyle : style.hexCode, colorTextButton : 0xFFFFFF, animationStyle : .noAnimation)
    }
  }
  
  static func presentTimePicker(time completion: @escaping (String) -> ()) {
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 150))
    datePicker.datePickerMode = .time
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    let selectAction: Action = {
      let dateString = dateFormatter.string(from: datePicker.date)
      completion(dateString)
    }
    
    let cancelAction: Action = { return }
    
    let appearance = Appearance.timePicker
    
    let alert = SCLAlertView(appearance: appearance)
    alert.addButton("Select", action: selectAction)
    alert.addButton("Cancel", action: cancelAction)
    alert.customSubview = datePicker
    
    DispatchQueue.main.async {
      alert.showTitle("Time", subTitle: "", style: .edit)
    }
  }
  
  static func presentDatePicker(date completion: @escaping (String) -> ()) {
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.5, height: 150))
    datePicker.datePickerMode = .date
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    
    let selectAction: Action = {
      let dateString = dateFormatter.string(from: datePicker.date)
      completion(dateString)
    }

    let cancelAction: Action = { return }
    
    let appearance = Appearance.datePicker
    
    let alert = SCLAlertView(appearance: appearance)
    alert.addButton("Select", action: selectAction)
    alert.addButton("Cancel", action: cancelAction)
    alert.customSubview = datePicker
      
    DispatchQueue.main.async {
      alert.showTitle("Date", subTitle: "", style: .edit)
    }
  }
}
