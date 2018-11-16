//
//  MovieDAO.swift
//  NextMovie
//
//  Created by Valmir Junior on 15/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import CoreData

class MovieCoreDataDAO {
    
    // MARK: - Properties
    let entityName = "Movie"
    
    // MARK: - Methods
    func list() throws -> [Movie] {
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: self.entityName)
        let sortDescriptor = NSSortDescriptor(keyPath: \Movie.title, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let movies = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            return movies
        } catch {
            throw Errors.coreDataError
        }
    }
    
    func save(movie: Movie) throws {
        
        do {
            CoreDataManager.shared.persistentContainer.viewContext.insert(movie)
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            throw Errors.coreDataError
        }
    }
    
    func update() throws {
        
        do {
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            throw Errors.coreDataError
        }
    }
    
    func delete(movie: Movie) throws {
        do {
            CoreDataManager.shared.persistentContainer.viewContext.delete(movie)
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            throw Errors.coreDataError
        }
    }
}
