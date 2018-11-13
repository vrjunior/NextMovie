//
//  UIViewController+DarkMode.swift
//  NextMovie
//
//  Created by Valmir Junior on 13/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func setupViewMode(darkMode: Bool) {
        
        self.tabBarController?.tabBar.barStyle = darkMode ? .black : .default
    }
}

