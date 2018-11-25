//
//  AppDelegate.swift
//  NextMovie
//
//  Created by Valmir Junior on 06/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //change the status bar to light style
        UINavigationBar.appearance().barStyle = UIBarStyle.blackOpaque
        
        return true
    }



}
