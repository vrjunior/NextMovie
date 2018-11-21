//
//  ApiDao.swift
//  NextMovie
//
//  Created by Valmir Junior on 21/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

enum Country: String {
    case br = "BR"
    case usa = "USA"
}

class MovieAPIDAO {
    
    private static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        configuration.timeoutIntervalForResource = 10.0
        configuration.allowsCellularAccess = false
        configuration.httpMaximumConnectionsPerHost = 5
        return configuration
    }()
    private static let session = URLSession(configuration: configuration)
    
    
    static func getMovieInfo(term: String, country: Country = .usa, onSuccess: () -> Void,
                             onFailure: (Error) ->  Void ) {
        
        guard let url = URL(string: APIRoute.iTunesBase) else {
            return onFailure(Errors.url)
        }
        
        
        
    }
}
