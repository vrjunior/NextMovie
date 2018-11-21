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
    
    
    static func getMovieInfo(term: String, country: Country = .usa, onSuccess: @escaping ([ItunesMovie]) -> Void,
                             onFailure: @escaping (Error) -> Void) {
        
        let mediaType = "movie"
        let entityType = "movie"
        
        guard var urlComp = URLComponents(string: APIRoute.iTunesBase) else {
            return onFailure(Errors.url)
        }
        
        let mediaParam = URLQueryItem(name: "media", value: mediaType)
        let entityParam = URLQueryItem(name: "entity", value: entityType)
        let countryParam = URLQueryItem(name: "country", value: country.rawValue)
        let termParam = URLQueryItem(name: "term", value: term)
        
        urlComp.queryItems = [mediaParam, entityParam, countryParam, termParam]
        
        guard let url = urlComp.url else {
            return onFailure(Errors.url)
        }
        
        
        self.session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                return onFailure(Errors.noResponse)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return onFailure(Errors.noResponse)
            }
            
            guard let data = data else {
                return onFailure(Errors.noData)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    guard let movies = try jsonDecoder.decode(ItunesResponse.self, from: data).results else {
                        return onFailure(Errors.noData)
                    }
                    
                    onSuccess(movies)
                } catch {
                    onFailure(Errors.invalidJSON)
                }
            default:
                return onFailure(Errors.httpError(code: httpResponse.statusCode))
            }
        }
       
        
    }
}
