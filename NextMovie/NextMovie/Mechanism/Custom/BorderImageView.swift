//
//  BorderImageView.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

@IBDesignable class BorderImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
