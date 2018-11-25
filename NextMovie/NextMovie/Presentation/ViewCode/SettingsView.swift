//
//  SettingsView.swift
//  NextMovie
//
//  Created by Valmir Junior on 25/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: class {
    func darkModeChanged(isEnabled: Bool)
    func autoPlayChanged(isEnabled: Bool)
    func isDarkModeEnabled() -> Bool
    func isAutoLayoutEnabled() -> Bool
}

final class SettingsView: UIView {
    
    // Properties
    public weak var delegate: SettingsViewDelegate?
    private var isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let darkModeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let darkModeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        label.textColor = .title
        label.text = Localization.darkMode
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let darkModeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitle
        label.textColor = .subtitle
        label.text = Localization.darkModeDescription
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let darkModeSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    let autoPlayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let autoPlayTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        label.textColor = .title
        label.text = Localization.autoPlay
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let autoPlaySubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitle
        label.textColor = .subtitle
        label.text = Localization.autoPlayDescription
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let autoPlaySwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    
    init(delegate: SettingsViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Methods
    
    @objc func darkModeSwitchDidChange(_ sender: UISwitch) {
        self.delegate?.darkModeChanged(isEnabled: sender.isOn)
    }
    
    @objc func autoPlaySwitchDidChange(_ sender: UISwitch) {
        self.delegate?.autoPlayChanged(isEnabled: sender.isOn)
    }
    
}

extension SettingsView: CodeView {
    
    func setupComponents() {
        
        darkModeStackView.addArrangedSubview(darkModeTitleLabel)
        darkModeStackView.addArrangedSubview(darkModeSubtitleLabel)
        darkModeStackView.addArrangedSubview(darkModeSwitch)
        
        autoPlayStackView.addArrangedSubview(autoPlayTitleLabel)
        autoPlayStackView.addArrangedSubview(autoPlaySubtitleLabel)
        autoPlayStackView.addArrangedSubview(autoPlaySwitch)
        
        verticalStackView.addArrangedSubview(darkModeStackView)
        verticalStackView.addArrangedSubview(autoPlayStackView)
        
        containerView.addSubview(verticalStackView)
        scrollView.addSubview(containerView)
        
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        
        // scroll view constraints
        scrollView.topAnchor
            .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
            .isActive = true
        scrollView.rightAnchor
            .constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0)
            .isActive = true
        scrollView.bottomAnchor
            .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            .isActive = true
        scrollView.leftAnchor
            .constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0)
            .isActive = true

        // container view constrails
        containerView.layoutMargins = UIEdgeInsets(top: 0, left: Margin.horizontal, bottom: 0, right: Margin.horizontal)

        containerView.topAnchor
            .constraint(equalTo: scrollView.topAnchor, constant: 0)
            .isActive = true
        containerView.rightAnchor
            .constraint(equalTo: scrollView.rightAnchor, constant: 0)
            .isActive = true
        containerView.bottomAnchor
            .constraint(equalTo: scrollView.bottomAnchor, constant: 0)
            .isActive = true
        containerView.leftAnchor
            .constraint(equalTo: scrollView.leftAnchor, constant: 0)
            .isActive = true
        containerView.widthAnchor
            .constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
            .isActive = true
        
        // vertial stack view contraints
        verticalStackView.topAnchor
            .constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: Margin.verticalNormal)
            .isActive = true
        
        verticalStackView.rightAnchor
            .constraint(equalTo: containerView.layoutMarginsGuide.rightAnchor)
            .isActive = true
        
        verticalStackView.bottomAnchor
            .constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: -Margin.verticalNormal)
            .isActive = true
        
        verticalStackView.leftAnchor
            .constraint(equalTo: containerView.layoutMarginsGuide.leftAnchor)
            .isActive = true
    }
    
    func setupExtraConfiguration() {
        
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchDidChange(_:)), for: .valueChanged)
        autoPlaySwitch.addTarget(self, action: #selector(autoPlaySwitchDidChange(_:)), for: .valueChanged)
        
        // dark mode
        self.backgroundColor = isDarkModeEnabled ? .black : .white
        self.darkModeTitleLabel.textColor = isDarkModeEnabled ? .white : .black
        self.autoPlayTitleLabel.textColor = isDarkModeEnabled ? .white : .black
        self.darkModeSubtitleLabel.textColor = isDarkModeEnabled ? .lightGray : .darkGray
        self.autoPlaySubtitleLabel.textColor = isDarkModeEnabled ? .lightGray : .darkGray
    }
}
