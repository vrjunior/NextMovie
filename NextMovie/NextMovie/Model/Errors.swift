//
//  Errors.swift
//  NextMovie
//
//  Created by Valmir Junior on 15/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

enum Errors: Error {
    case invalidJSON
    case url
    case noResponse
    case noData
    case httpError(code: Int)
    case coreDataError
}
