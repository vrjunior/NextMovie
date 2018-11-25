//
//  SettingsViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 13/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    

    // MARK: - Properties
    typealias CustomView = SettingsView
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = Localization.settings
    }
    
    override func loadView() {
        view = CustomView(delegate: self)
    }
    
    
    // MARK: - Methods
}

extension SettingsViewController: SettingsViewDelegate {
    
    func darkModeChanged(isEnabled: Bool) {
        UserDefaultsManager.isDarkModeEnabled = isEnabled
    }
    
    func autoPlayChanged(isEnabled: Bool) {
        UserDefaultsManager.isAutoPlayEnabled = isEnabled
    }
    
    func isDarkModeEnabled() -> Bool {
        return UserDefaultsManager.isDarkModeEnabled
    }
    
    func isAutoLayoutEnabled() -> Bool {
        return UserDefaultsManager.isAutoPlayEnabled
    }
}
