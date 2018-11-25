//
//  SettingsNavigationViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 25/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class SettingsNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingsViewController = SettingsViewController()
        self.viewControllers = [settingsViewController]
    }
}
