//
//  UIImage+Resized.swift
//  NextMovie
//
//  Created by Valmir Junior on 15/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(to maxSize: CGFloat) -> UIImage? {
        
        let oldHeight = self.size.height
        let oldWidth = self.size.width
        
        let scaleFactor = (oldWidth > oldHeight) ? (oldWidth / maxSize) : (oldHeight / maxSize)
        
        let newWidth =  oldWidth / scaleFactor
        let newHeight =  oldHeight / scaleFactor
        let smallSize = CGSize(width: newWidth, height: newHeight)
        
        // Image context
        UIGraphicsBeginImageContext(smallSize)
        self.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return smallImage
    }
    
}
