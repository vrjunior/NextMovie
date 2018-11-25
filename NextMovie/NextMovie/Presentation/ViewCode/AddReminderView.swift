//
//  AddReminderView.swift
//  NextMovie
//
//  Created by Valmir Junior on 25/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

// swiftlint:disable function_body_length
// disabling because view code

import UIKit

protocol AddReminderViewDelegate: class {
    func createReminder(title: String, subtitle: String?, body: String, date: Date)
}

final class AddReminderView: UIView {
    
    // MARK: - Properties
    public weak var delegate: AddReminderViewDelegate?
    public var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            self.setTitle(movie: movie)
        }
    }
    private var isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
    
    // MARK: - Subviews
    let keyboardScrollView: KeyboardScrollView = {
        let scrollView = KeyboardScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .title
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Escreva algum comentário"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let notificationDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar", for: .normal)
        button.backgroundColor = .redPrimary
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    convenience init(delegate: AddReminderViewDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Methods
    private func setTitle(movie: Movie) {
        let movieTitle = movie.title ?? ""
        self.titleLabel.text = "Lembrete para assistir o filme \(movieTitle)"
    }
}


extension AddReminderView: CodeView {
    
    func setupComponents() {
        addSubview(keyboardScrollView)
        keyboardScrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionTextField)
        containerView.addSubview(notificationDatePicker)
        containerView.addSubview(createButton)
    }
    
    func setupConstraints() {
        
        // scroll view contraints
        keyboardScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
            .isActive = true
        keyboardScrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0)
            .isActive = true
        keyboardScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            .isActive = true
        keyboardScrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0)
            .isActive = true
        
        // container view constraints
        containerView.layoutMargins = UIEdgeInsets(top: 0, left: Margin.horizontal, bottom: 0, right: Margin.horizontal)
        containerView.topAnchor.constraint(equalTo: keyboardScrollView.topAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: keyboardScrollView.rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: keyboardScrollView.bottomAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: keyboardScrollView.leftAnchor, constant: 0).isActive = true
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        let containerHeight = containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1)
        containerHeight.priority = UILayoutPriority(250)
        containerHeight.isActive = true
        

        // title contraints
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin.verticalLarge)
            .isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.layoutMarginsGuide.rightAnchor, constant: 0)
            .isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leftAnchor, constant: 0)
            .isActive = true
        
        // description text field constraints
        descriptionTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.verticalLarge)
            .isActive = true
        descriptionTextField.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0)
            .isActive = true
        descriptionTextField.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0)
            .isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        // date picker constraints
        notificationDatePicker.topAnchor
            .constraint(equalTo: descriptionTextField.bottomAnchor, constant: Margin.verticalLarge)
            .isActive = true
        notificationDatePicker.rightAnchor.constraint(equalTo: descriptionTextField.rightAnchor, constant: 0)
            .isActive = true
        notificationDatePicker.leftAnchor.constraint(equalTo: descriptionTextField.leftAnchor, constant: 0)
            .isActive = true
        
        // button constraints
        createButton.topAnchor
            .constraint(equalTo: notificationDatePicker.bottomAnchor, constant: Margin.verticalVeryLarge)
            .isActive = true
        createButton.rightAnchor.constraint(equalTo: notificationDatePicker.rightAnchor, constant: 0)
            .isActive = true
        createButton.leftAnchor.constraint(equalTo: notificationDatePicker.leftAnchor, constant: 0)
            .isActive = true
        createButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Margin.verticalLarge)
            .isActive = true

        createButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setupExtraConfiguration() {

        createButton.addTarget(self, action: #selector(createReminderButtonPressed(_:)), for: .touchUpInside)
        
        // dark mode
        self.backgroundColor = isDarkModeEnabled ? .black : .white
        self.titleLabel.textColor = isDarkModeEnabled ? .white : .black
        
        if isDarkModeEnabled {
            self.notificationDatePicker.setValue(UIColor.white, forKey: "textColor")
        } else {
            self.notificationDatePicker.setValue(UIColor.black, forKey: "textColor")
        }
    }
    
    @objc func createReminderButtonPressed(_ sender: Any) {
        guard let title = titleLabel.text else { return }
        var body = "Lembrete criado em \(Date().formatted)"
        var subtitle: String?
        
        if let description = self.descriptionTextField.text, !description.isEmpty {
            subtitle = body
            body = description
        }
        
        let date = self.notificationDatePicker.date
        
        self.delegate?.createReminder(title: title, subtitle: subtitle, body: body, date: date)
    }
}
