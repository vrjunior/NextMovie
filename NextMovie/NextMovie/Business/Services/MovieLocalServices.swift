//
//  MovieServices.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit.NSDataAsset
import Foundation

class MovieLocalServices {
    
    class func list() -> [Movie]? {
        
        let movieDAO = MovieCoreDataDAO()

        do {
            let movies = try movieDAO.list()
            return movies
        } catch {
            print(error)
        }
        
        return nil
    }
    
    class func save(movie: Movie) {
        
        let movieDAO = MovieCoreDataDAO()
        
        do {
            try movieDAO.save(movie: movie)
        } catch {
            print(error)
        }
    }
    
    class func update() {
        
        let movieDAO = MovieCoreDataDAO()
        
        do {
            try movieDAO.update()
        } catch {
            print(error)
        }
    }
    
    class func delete(movie: Movie) {
        let movieDAO = MovieCoreDataDAO()
        
        do {
            try movieDAO.delete(movie: movie)
        } catch {
            print(error)
        }
    }
}
