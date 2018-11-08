//
//  KeyboardScrollView.swift
//  NextMovie
//
//  Created by Valmir Junior on 08/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class KeyboardScrollView: UIScrollView {
    
    // MARK: - Super Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.registerToKeyboardNotification()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.registerToKeyboardNotification()
    }
    
    deinit {
        self.unregisterToKeyboardNotification()
    }
    
    
    // MARK: - Methods
    private func registerToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height else { return }
        
        self.contentInset.bottom = height
        self.scrollIndicatorInsets.bottom = height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.contentInset.bottom = 0
        self.scrollIndicatorInsets.bottom = 0
    }
}
