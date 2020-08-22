//
//  Font.swift
//  ToDoList
//
//  Created by 안재영 on 2020/08/11.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit

struct Font {
  struct System {
    static func nomal(size: CGFloat) -> UIFont {
      return UIFont.systemFont(ofSize: size)
    }
    static func bold(size: CGFloat) -> UIFont {
      return UIFont.boldSystemFont(ofSize: size)
    }
  }
  struct Helvetica {
    static func condensedBlack(size: CGFloat) -> UIFont {
      return UIFont(name: "HelveticaNeue-CondensedBlack", size: size)!
    }
    static func bold(size: CGFloat) -> UIFont {
      return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    static func medium(size: CGFloat) -> UIFont {
      return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
  }
  struct Avenir {
    static func demiBold(size: CGFloat) -> UIFont {
      return UIFont(name: "AvenirNextCondensed-DemiBold", size: size)!
    }
    static func bold(size: CGFloat) -> UIFont {
      return UIFont(name: "AvenirNextCondensed-Bold", size: size)!
    }
  }
}
