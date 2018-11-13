//
//  UserDefaultsManager.swift
//  NextMovie
//
//  Created by Valmir Junior on 13/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

enum UDKey {
    static let darkMode = "darkMode"
    static let autoPlay = "autoPlay"
}


class UserDefaultsManager {
    
    static var isDarkModeEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UDKey.darkMode)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKey.darkMode)
        }
    }
    
    static var isAutoPlayEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UDKey.autoPlay)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKey.autoPlay)
        }
    }
}


