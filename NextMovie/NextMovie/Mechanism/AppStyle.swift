//
//  AppStyle.swift
//  NextMovie
//
//  Created by Valmir Junior on 25/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

extension UIColor {
    static let redPrimary: UIColor = #colorLiteral(red: 1, green: 0.1490196078, blue: 0, alpha: 1)
    static let greyishBrown = UIColor(r: 76, g: 76, b: 76)
    
    // App context colors
    static let body = UIColor.darkGray
    static let bodyDarkMode = UIColor.white
    static let title = UIColor.black
    static let titleDarkMode = UIColor.white
    static let subtitle = UIColor.darkGray
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}

extension UIFont {
    static let title = UIFont.boldSystemFont(ofSize: 28)
    static let title2 = UIFont.boldSystemFont(ofSize: 20)
    static let subtitle = UIFont.systemFont(ofSize: 16)
    static let body = UIFont.systemFont(ofSize: 15)
}

enum Margin {
    static let horizontal: CGFloat = 24
    static let horizontalSmall: CGFloat = 16
    static let verticalSmall: CGFloat = 8
    static let verticalNormal: CGFloat = 16
    static let verticalLarge: CGFloat = 24
    static let verticalVeryLarge: CGFloat = 72
}
