//
//  Date+Formatted.swift
//  NextMovie
//
//  Created by Valmir Junior on 16/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

extension Date {
    
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: self)
    }
}
