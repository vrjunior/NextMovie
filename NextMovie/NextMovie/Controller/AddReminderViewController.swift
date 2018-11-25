//
//  AddReminderViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 16/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import UserNotifications

class AddReminderViewController: UIViewController {
    
    // MARK: - Properties
    public var movie: Movie!
    typealias CustomView = AddReminderView
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if movie == nil {
            print("Reminder needs a movie")
            self.navigationController?.popViewController(animated: true)
            return
        }
    }
    
    override func loadView() {
        
        let customView = CustomView(delegate: self)
        customView.movie = self.movie
        view = customView
    }
    
    override func setupViewMode(darkMode: Bool) {
        
        super.setupViewMode(darkMode: darkMode)
    }
    
    // MARK: - Methods
}

extension AddReminderViewController: AddReminderViewDelegate {
    
    func createReminder(title: String, subtitle: String?, body: String, date: Date) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            print(success)
            if let error = error {
                print(error)
            }
        }
        
        let id = String(Date().timeIntervalSince1970)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = NotificationCategory.reminder
        
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                                             from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
