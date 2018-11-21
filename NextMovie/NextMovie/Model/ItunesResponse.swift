//
//  iTunesResponse.swift
//  NextMovie
//
//  Created by Valmir Junior on 21/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

struct ItunesResponse {
    let resultCount: Int?
    let results: [ItunesMovie]?
}

extension ItunesResponse: Codable { }
