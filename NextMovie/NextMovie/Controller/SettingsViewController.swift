//
//  SettingsViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 13/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var darkModeTitleFixedLabel: UILabel!
    @IBOutlet weak var darkModeDescriptionFixedLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var autoPlayTitleFixedLabel: UILabel!
    @IBOutlet weak var autoPlayDescriptionFixedLabel: UILabel!
    @IBOutlet weak var autoPlaySwitch: UISwitch!
    
    
    // MARK: - Properties
    
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        
        self.darkModeSwitch.isOn = isDarkModeEnabled
        self.setupViewMode(darkMode: isDarkModeEnabled)
    }
    
    // MARK: - Methods
    
    
    // MARK: - IBActions
    @IBAction func darkModeValueChanged(_ sender: UISwitch) {
        let isDarkModeEnabled = sender.isOn
        UserDefaultsManager.isDarkModeEnabled = isDarkModeEnabled
        
        self.setupViewMode(darkMode: isDarkModeEnabled)
    }
    
    @IBAction func autoPlayValueChanged(_ sender: Any) {
        
    }
    
    
    override func setupViewMode(darkMode: Bool) {
        super.setupViewMode(darkMode: darkMode)
        
        self.view.backgroundColor = darkMode ? .black : .white
        self.darkModeTitleFixedLabel.textColor = darkMode ? .white : .black
        self.autoPlayTitleFixedLabel.textColor = darkMode ? .white : .black
        self.darkModeDescriptionFixedLabel.textColor = darkMode ? .lightGray : .darkGray
        self.autoPlayDescriptionFixedLabel.textColor = darkMode ? .lightGray : .darkGray
    }
    
}
