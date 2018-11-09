//
//  MovieServices.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit.NSDataAsset
import Foundation

class MovieServices {
    
    class func list() -> [Movie]? {
        guard let movieData = NSDataAsset(name: "movies")?.data else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let movies = try decoder.decode([Movie].self, from: movieData)
            return movies
        } catch {
            print(error)
        }
        
        return nil
    }
}
