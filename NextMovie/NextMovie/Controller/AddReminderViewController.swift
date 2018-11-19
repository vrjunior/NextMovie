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
    
    // MARK: - IBOutlets
    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var reminderDescriptionTextField: UITextField!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: - Properties
    public var movie: Movie!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        guard let movie = movie else {
            print("Reminder needs a movie")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        self.reminderDatePicker.minimumDate = Date()
        self.prepare(with: movie)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        self.setupViewMode(darkMode: isDarkModeEnabled)
    }
    
    override func setupViewMode(darkMode: Bool) {
        
        super.setupViewMode(darkMode: darkMode)
        self.view.backgroundColor = darkMode ? .black : .white
        self.reminderTitleLabel.textColor = darkMode ? .white : .black
        
        if darkMode {
            self.reminderDatePicker?.setValue(UIColor.white, forKey: "textColor")
        } else {
            self.reminderDatePicker?.setValue(UIColor.black, forKey: "textColor")
        }
    }
    
    // MARK: - Methods
    private func prepare(with movie: Movie) {
        self.reminderTitleLabel.text = "Lembrete para assistir o filme \(movie.title ?? "")"
    }
    
    // MARK: - IBActions
    @IBAction func createReminder(_ sender: Any) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            print(success)
            if let error = error {
                print(error)
            }
        }
        
        let id = String(Date().timeIntervalSince1970)
        
        let content = UNMutableNotificationContent()
        content.title = self.reminderTitleLabel.text ?? ""
        
        content.body = "Lembrete criado em \(Date().formatted)"
        content.categoryIdentifier = NotificationCategory.reminder
        
        if let description = self.reminderDescriptionTextField.text, !description.isEmpty {
            content.subtitle = content.body
            content.body = description
        }
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                                                             from: self.reminderDatePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
