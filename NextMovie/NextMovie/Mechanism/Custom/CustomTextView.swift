//
//  UITextView+Placeholder+Border.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

/// Extend UITextView and implemented UITextViewDelegate to listen for changes
@IBDesignable class CustomTextView: UITextView, UITextViewDelegate {
    
    /// The UITextView placeholder text
    @IBInspectable public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.placeholderLabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            guard let placeholderLabel = self.placeholderLabel else {
                self.addPlaceholder(newValue!)
                return
            }
            
            placeholderLabel.text = newValue
            placeholderLabel.sizeToFit()
        }
    }
    
    @IBInspectable var placeholderTextColor: UIColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.placeholderLabel?.textColor = self.placeholderTextColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    private var placeholderLabel: UILabel? {
        return self.viewWithTag(100) as? UILabel
    }
    
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
        
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        guard let placeholderLabel = self.placeholderLabel else {
            return
        }
        let labelX = self.textContainer.lineFragmentPadding
        let labelY = self.textContainerInset.top - 2
        let labelWidth = self.frame.width - (labelX * 2)
        let labelHeight = placeholderLabel.frame.height
        
        placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.gray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
    override var text: String! {
        didSet {
            placeholderLabel?.isHidden = self.text.count > 0
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
}
