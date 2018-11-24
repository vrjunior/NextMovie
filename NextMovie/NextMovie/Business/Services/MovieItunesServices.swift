//
//  MovieItunesServices.swift
//  NextMovie
//
//  Created by Valmir Junior on 24/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

// swiftlint:disable multiple_closures_with_trailing_closure
import Foundation

class MovieItunesServices {
    
    class func getMovieInfo(term: String, country: Country = .usa, onSuccess: @escaping ([ItunesMovie]) -> Void,
                            onFailure: @escaping (Error) -> Void) {
        
        let movieApiDao = MovieAPIDAO()
        
        
        DispatchQueue.global().async(qos: .userInitiated) {
            
            movieApiDao.getMovieInfo(term: term, country: country, onSuccess: { (movies) in
                
                DispatchQueue.main.async {
                    onSuccess(movies)
                }
            }) { (error) in
                
                DispatchQueue.main.async {
                    onFailure(error)
                }
            }
        }
    }
}
